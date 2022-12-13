network_name = "jca-tfe-vpc"
subnetwork_name = "jca-tfe-subnet"
# env = "dev"
project_id = "hc-f9c018d37d474b2c92199cca677"
cluster_region = "us-east1"
cluster_name = "jca-gke-demo"
cluster_description = "TFE Agent Test Cluster"

# master_authorized_network_name = "home"
# master_authorized_cidr_block = "140.177.227.38/32"

cluster_resource_labels =  {
      env = "hc-f9c018d37d474b2c92199cca677",
      owner = "janderton"
    }

node_labels =  {
      env = "hc-f9c018d37d474b2c92199cca677",
      owner = "janderton"
    }
node_tags = ["allow-http", "allow-https"]
default_node_pool = true

min_master_version = "latest"
