variable "env" {}
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
