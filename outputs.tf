output "cluster_endpoint" {
  description = "The IP address of the cluster master."
  sensitive   = true
  value       = module.google_container_cluster.commons-gke.endpoint
}
