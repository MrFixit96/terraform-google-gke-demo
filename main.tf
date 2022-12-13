/**********************************************
*      Create GKE commons-gke
**********************************************/

module "commons-gke" {
  source         = "github.com/mrfixit96/terraform-gke"
  environment    = var.env
  project        = var.project_id
  region         = var.cluster_region
  cluster_name   = var.cluster_name

  network         = var.network_name
  subnetwork_name =  var.subnetwork_name

  node_labels              = var.node_labels
  node_tags                = var.node_tags
  default_node_pool        = var.default_node_pool
}
