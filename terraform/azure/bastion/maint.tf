
# Create resource group and virtual network

# Create a resource group if it doesn’t exist.
/*resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_prefix}-rg"
  location = "${var.location}"

  tags = "${var.tags}"
}*/

# Create virtual network with public and private subnets.
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group

  tags = var.tags
}

# Create public subnet and security group

# Create public subnet for hosting bastion/public VMs.
resource "azurerm_subnet" "public_subnet" {
  name                      = "${var.resource_prefix}-pblc-sn001"
  resource_group_name       = var.resource_group
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefix            = "10.0.1.0/24"
  //network_security_group_id = "${azurerm_network_security_group.public_nsg.id}"
  //azurerm_subnet_network_security_group_association = azurerm_subnet_network_security_group_association.public_subnet_assoc.id

  # List of Service endpoints to associate with the subnet.
  service_endpoints         = [
    "Microsoft.ServiceBus",
    "Microsoft.ContainerRegistry"
  ]
}

# Create network security group and SSH rule for public subnet.
resource "azurerm_network_security_group" "public_nsg" {
  name                = "${var.resource_prefix}-pblc-nsg"
  location            = var.location
  resource_group_name = var.resource_group

  # Allow SSH traffic in from Internet to public subnet.
  security_rule {
    name                       = "allow-ssh-all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Associate network security group with public subnet.
resource "azurerm_subnet_network_security_group_association" "public_subnet_assoc" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}

# Create public IP address and NIC for bastion host

# Create a public IP address for bastion host VM in public subnet.
resource "azurerm_public_ip" "public_ip" {
  name                         = "${var.resource_prefix}-ip"
  location                     = var.location
  resource_group_name          = var.resource_group
  allocation_method            = "Dynamic"
  domain_name_label            = "gv-bastion"

  tags = var.tags
}

# Create network interface for bastion host VM in public subnet.
resource "azurerm_network_interface" "bastion_nic" {
  name                      = "${var.resource_prefix}-bstn-nic"
  location                  = var.location
  resource_group_name       = var.resource_group
  network_security_group_id = azurerm_network_security_group.public_nsg.id

  ip_configuration {
    name                          = "${var.resource_prefix}-bstn-nic-cfg"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  tags = var.tags
}

# Create private subnet and security group

# Create private subnet for hosting worker VMs.
resource "azurerm_subnet" "private_subnet" {
  name                      = "${var.resource_prefix}-prvt-sn001"
  resource_group_name       = var.resource_group
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefix            = "10.0.2.0/24"
  //network_security_group_id = "${azurerm_network_security_group.private_nsg.id}"

  # List of Service endpoints to associate with the subnet.
  service_endpoints         = [
    "Microsoft.Sql",
    "Microsoft.ServiceBus"
  ]
}

# Create network security group and SSH rule for private subnet.
resource "azurerm_network_security_group" "private_nsg" {
  name                = "${var.resource_prefix}-prvt-nsg"
  location            = var.location
  resource_group_name = var.resource_group

  # Allow SSH traffic in from public subnet to private subnet.
  security_rule {
    name                       = "allow-ssh-public-subnet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  }

  # Block all outbound traffic from private subnet to Internet.
  security_rule {
    name                       = "deny-internet-all"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Associate network security group with private subnet.
resource "azurerm_subnet_network_security_group_association" "private_subnet_assoc" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}

# Create NIC for worker host

# Create network interface for worker host VM in private subnet.
resource "azurerm_network_interface" "worker_nic" {
  name                      = "${var.resource_prefix}-wrkr-nic"
  location                  = var.location
  resource_group_name       = var.resource_group
  network_security_group_id = azurerm_network_security_group.private_nsg.id

  ip_configuration {
    name                          = "${var.resource_prefix}-wrkr-nic-cfg"
    subnet_id                     = azurerm_subnet.private_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# Create storage account for diagnostics

# Generate random text for a unique storage account name.
resource "random_id" "random_id" {
  keepers = {

    # Generate a new ID only when a new resource group is defined.
    resource_group = var.resource_group
  }

  byte_length = 8
}

# Create storage account for boot diagnostics.
resource "azurerm_storage_account" "storage_account" {
  name                        = "diag${random_id.random_id.hex}"
  resource_group_name         = var.resource_group
  location                    = var.location
  account_tier                = "Standard"
  account_replication_type    = "LRS"

  tags = var.tags
}

# Create virtual machines for bastion and worker hosts

# Create bastion host VM.
resource "azurerm_virtual_machine" "bastion_vm" {
  name                  = "${var.resource_prefix}-bstn-vm001"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "${var.resource_prefix}-bstn-dsk001"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.resource_prefix}-bstn-vm001"
    admin_username = var.username
    //custom_data =  file("${path.module}/files/nginx.yml")
  }

  os_profile_linux_config {
    disable_password_authentication = true

    # Bastion host VM public key.
    ssh_keys {
      path     = "/home/${var.username}/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  boot_diagnostics {
    enabled = "true"
    storage_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
  }

  tags = var.tags
}

# Create worker host VM.
resource "azurerm_virtual_machine" "worker_vm" {
  name                  = "${var.resource_prefix}-wrkr-vm001"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.worker_nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "${var.resource_prefix}-wrkr-dsk001"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.resource_prefix}-wrkr-vm001"
    admin_username = var.username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    # Worker host VM public key.
    ssh_keys {
      path     = "/home/${var.username}/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  boot_diagnostics {
    enabled = "true"
    storage_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
  }

  tags = var.tags
}