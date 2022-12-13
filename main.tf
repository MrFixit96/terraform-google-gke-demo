/**********************************************
*      Create GKE commons-gke
**********************************************/

module "commons-gke" {
 # source         = "github.com/mrfixit96/terraform-gke"
 source  = "terraform-google-modules/kubernetes-engine/google"
  version = "24.0.0"
  #environment      = var.env
  project_id        = var.project_id
  region            = var.cluster_region
  name              = var.cluster_name
  description       = var.cluster_description

  kubernetes_version    = var.min_master_version

  network           = var.network_name
  subnetwork        = var.subnetwork_name
  ip_range_pods     = var.ip_range_pods
  ip_range_services = var.ip_range_services

  cluster_resource_labels  = var.cluster_resource_labels
  node_labels              = var.node_labels
  node_tags                = var.node_tags
  default_node_pool        = var.default_node_pool
}
