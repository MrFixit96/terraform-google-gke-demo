# variable "env" {}
variable "project_id" {}
variable "credential_file" {}
variable "cluster_region" {}
variable "cluster_name" {}
variable "network_name" {
  default = "default"
}
variable "subnetwork_name" {
  default = "default"
}
variable "node_labels" {}
variable "node_tags" {}
variable "default_node_pool" {}
variable "min_master_version" {
  default = "latest"
}
variable "cluster_description" {
  default ="Test GKE Cluster"
}

variable "ip_range_pods" {
  description = "The name of the clusters ip alias range used for pods"
  default = "ip-cidr-range-k8-pod"
}
variable "ip_range_services" {
  description = "The name of the clusters ip alias range used for services"
  default = "ip-cidr-range-k8-services"
}

variable "cluster_resource_labels" {}
