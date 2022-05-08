variable "prefix" {
  type = string
  default = "simple"
}

variable "location" {
  type = string
  default = "westeurope"
}

variable "resource_group" {
  type = string
  default = "rsg-int-gver"
}

variable "tags" {
  type = map

  default = {
    Environment = "Terraform Simple VM"
  }
}
