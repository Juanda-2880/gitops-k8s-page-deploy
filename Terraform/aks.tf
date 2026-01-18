# Resource Group Creation
# Acts as a logical container for all Azure resources.
# Helps with lifecycle management (deleting the RG deletes everything inside).
resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# AKS Cluster Creation - The Control Plane
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = var.dns_prefix

  # SYSTEM NODE POOL
  # Reserved for critical K8s system pods (CoreDNS, metrics-server, etc.).
  # It is best practice to keep this separate from application workloads.
  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = var.vm_size
  }

  # Managed Identity
  # Allows AKS to interact with other Azure resources (like Load Balancers)
  # without managing Service Principals manually.
  identity {
    type = "SystemAssigned"
  }

  # Network Configuration
  # "azure" CNI: Each pod gets a real IP from the VNet.
  # Better performance than 'kubenet', but consumes more IP addresses.
  network_profile {
    network_plugin = "azure"
  }
}

# USER NODE POOL (Game Workloads)
# A dedicated node pool specifically for the game application.
# If the game consumes too many resources or crashes, it won't affect the system stability.
resource "azurerm_kubernetes_cluster_node_pool" "user_pool" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = var.vm_size
  node_count            = 1
  mode                  = "User" # Indicates this pool is for applications, not system pods.

  # Node Labels
  # Useful for scheduling. You can use 'nodeSelector' in your K8s manifests
  # to force the game to run ONLY on these nodes.
  node_labels = {
    "nodepool-type" = "user-nodes"
  }
}