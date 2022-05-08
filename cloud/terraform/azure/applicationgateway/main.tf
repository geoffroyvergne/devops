/*resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_prefix}-rg"
  location = var.location
  tags = var.tags
}*/

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}-vnet"
  resource_group_name = var.resource_group
  location            = var.location
  address_space       = ["10.254.0.0/16"]
}

resource "azurerm_subnet" "frontend_subnet" {
  name                 = "${var.resource_prefix}-frontend-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.254.0.0/24"
}

resource "azurerm_subnet" "backend_subnet" {
  name                 = "${var.resource_prefix}-backend-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.254.2.0/24"
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.resource_prefix}-public_ip"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label = "gv-app-gateway"
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnet.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.vnet.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.vnet.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.vnet.name}-rdrcfg"
}

resource "azurerm_application_gateway" "appgateway" {
  name                = "${var.resource_prefix}-appgateway"
  resource_group_name = var.resource_group
  location            = var.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "${var.resource_prefix}-ip-configuration"
    subnet_id = azurerm_subnet.frontend_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
    //ip_addresses = []
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}