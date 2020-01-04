variable "tags" {
  description = "A map of the tags to use for the resources that are deployed."
  type        = map

  default = {
    name                    = "Kubernetes basic"
    environment             = "Sandbox"
    infrastructureversion   = "1.0.0"
  }
}

variable "resource_group" {
  type = string
  default = "rsg-int-gver"
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Azure region for deployment of resources."
}

variable "resource_prefix" {
  type        = string
  default     = "basic-k8s"
  description = "Service prefix to use for naming of resources."
}

variable "kubernetes_client_id" {
  description = "The Client ID for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "kubernetes_client_secret" {
  description = "The Client Secret for the Service Principal to use for this Managed Kubernetes Cluster"
}
