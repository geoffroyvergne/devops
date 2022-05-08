# Create a resource group if it doesn’t exist.
/*resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_prefix}-rg"
  location = "${var.location}"

  tags = "${var.tags}"
}*/

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.resource_prefix}-k8s"
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "${var.resource_prefix}-k8s"

  linux_profile {
    admin_username = "azureuser"

    ssh_key {
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "Standard_D1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.kubernetes_client_id
    client_secret = var.kubernetes_client_secret
  }

  tags = var.tags
}