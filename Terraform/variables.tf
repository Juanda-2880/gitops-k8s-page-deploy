# Resource Group Name
# Defines the logical container name where all resources will be grouped.
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Azure Region
# Determines the physical data center location (e.g., East US 2).
# Choosing the right region is crucial for latency and compliance.
variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
}

# Cluster Name
# The identifier for the AKS cluster as it will appear in the Azure Portal.
variable "aks_cluster_name" {
  description = "AKS cluster name"
  type        = string
}

# DNS Prefix
# Used to generate the Fully Qualified Domain Name (FQDN) for the API server.
# It must be unique within the Azure region.
# Example result: myaksdns-341324.hcp.eastus2.azmk8s.io
variable "dns_prefix" {
  description = "AKS DNS prefix"
  type        = string
}

# VM Size (Node Sku)
# Defines the CPU and RAM available for the nodes.
# "Standard_D2_v2" is a general-purpose instance, good for dev/test environments.
variable "vm_size" {
  description = "Size of the VM to use for the AKS"
  type        = string
}