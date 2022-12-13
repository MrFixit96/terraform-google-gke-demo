network_name = "jca-tfe-vpc"
subnetwork_name = "jca-tfe-subnet"
env = "dev"
project_id = "hc-f9c018d37d474b2c92199cca677"
cluster_region = "us-east1"
cluster_name = "jca-gke-demo"
master_authorized_network_name = "home"
master_authorized_cidr_block = "140.177.227.38/32"
node_labels =  {
      env = var.project_id,
      owner = "janderton"
    }
node_tags = ["allow-http", "allow-https"]
default_node_pool = true
