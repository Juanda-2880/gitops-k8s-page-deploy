resource_group_name     = "myAksResourceGroup"

# "eastus2" is often chosen for its lower cost and high availability compared to other regions.
resource_group_location = "eastus2"

aks_cluster_name        = "myAksCluster"

# This prefix will be part of your Kubernetes API URL.
dns_prefix              = "myaksdns"

# Standard_D2_v3: 2 vCPUs, 8 GiB RAM.
# Sufficient for a small game server and learning purposes.
vm_size                 = "Standard_D2_v3"