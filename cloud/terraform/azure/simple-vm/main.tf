/*provider "azurerm" {
  //use_msi = true
  subscription_id = ""
  tenant_id       = ""
}*/

/*resource "azurerm_resource_group" "myterraformgroup" {
  name     = "rsg-int-gver"
  location = "var.location"
}*/

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.1.0/24"
}

# Create public IPs
resource "azurerm_public_ip" "publicip" {
  name                         = "${var.prefix}publicip"
  location                     = var.location
  resource_group_name          = var.resource_group
  allocation_method            = "Dynamic"
  tags                         = var.tags
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg-front" {
  name                = "${var.prefix}-nsg"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags                         = var.tags
}

# Create network interface
resource "azurerm_network_interface" "nic-vm-1" {
  name                      = "${var.prefix}-nic"
  location                  = var.location
  resource_group_name       = var.resource_group
  network_security_group_id = azurerm_network_security_group.nsg-front.id

  ip_configuration {
    name                          = "${var.prefix}NicConfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    //private_ip_address_allocation = "Dynamic"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.5"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }

  tags                         = var.tags
}

# Create virtual machine
resource "azurerm_virtual_machine" "vm-1" {
  name                  = "${var.prefix}-vm-1"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.nic-vm-1.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "${var.prefix}-vm-1-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.prefix}-vm-1"
    admin_username = "azureuser"
    //custom_data =  CloudInit
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  provisioner "local-exec" {
    command = "echo The server's IP address is ${azurerm_public_ip.publicip.ip_address}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
  }

  tags                         = var.tags
}

# Create Managed data disk
resource "azurerm_managed_disk" "data-disk-1" {
  name                 = "${var.prefix}-data-disk-1"
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

# Attach Managed data disk to vm
resource "azurerm_virtual_machine_data_disk_attachment" "data-disk-1" {
  managed_disk_id    = azurerm_managed_disk.data-disk-1.id
  virtual_machine_id = azurerm_virtual_machine.vm-1.id
  lun                = "10"
  caching            = "ReadWrite"
}