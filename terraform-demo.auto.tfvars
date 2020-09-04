env = "dev"
project_id = "jca-tfe-testing-1da3236b"
cluster_region = "us-central1"
cluster_name = "terraform-gke-demo"
master_authorized_network_name = "home"
master_authorized_cidr_block = "140.177.245.29/32"
node_labels = ["owner=jca"] 
node_tags = ["allow-http", "allow-https"]
default_node_pool = true
