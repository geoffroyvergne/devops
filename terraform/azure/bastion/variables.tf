# Define the common tags for all resources.
variable "tags" {
  description = "A map of the tags to use for the resources that are deployed."
  type        = map

  default = {
    name                    = "HighCharity Infra"
    tier                    = "Infrastructure"
    application             = "HighCharity"
    applicationversion      = "1.0.0"
    environment             = "Sandbox"
    infrastructureversion   = "1.0.0"
  }
}

variable "resource_group" {
  type = string
  default = "rsg-int-gver"
}

# Define prefix for consistent resource naming.
variable "resource_prefix" {
  type        = string
  default     = "bastion"
  description = "Service prefix to use for naming of resources."
}

# Define Azure region for resource placement.
variable "location" {
  type        = string
  default     = "westeurope"
  description = "Azure region for deployment of resources."
}

# Define username for use on the hosts.
variable "username" {
  type        = string
  default     = "azureuser"
  description = "Username to build and use on the VM hosts."
}