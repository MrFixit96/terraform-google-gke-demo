/* Requires the following ENV Vars
GOOGLE_REGION=
GOOGLE_CREDENTIALS=
GOOGLE_PROJECT=
 */

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    google = {
    }
    helm = {
      source  = "hashicorp/helm"
      #version = ">= 2.1.0"
    }
  }
}

# Provider is configured using environment variables: GOOGLE_REGION, GOOGLE_PROJECT, GOOGLE_CREDENTIALS.
# This can be set statically, if preferred. See docs for details.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#full-reference
provider "google" {}

# Configure kubernetes provider with Oauth2 access token.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.
data "google_client_config" "default" {
  #depends_on = [module.commons-gke]
}

# Defer reading the cluster data until the GKE cluster exists.
data "google_container_cluster" "default" {
  name       = var.cluster_name
  location = var.cluster_region
  #depends_on = [module.commons-gke]
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.default.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.default.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
    )
  }
}

locals {
  app2_fqdn = "vault.gcp.janderton.com"
}

resource "kubernetes_namespace" "test" {
  #depends_on   = [module.gke-cluster]
  
  metadata {
    name = "test"
  }
}

resource "kubernetes_deployment" "test" {
  #depends_on   = [module.gke-cluster]
  
  metadata {
    name      = "test"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "test"
      }
    }
    template {
      metadata {
        labels = {
          app = "test"
        }
      }
      spec {
        container {
          image = "nginx:1.19.4"
          name  = "nginx"

          resources {
            limits = {
              memory = "512M"
              cpu    = "1"
            }
            requests = {
              memory = "256M"
              cpu    = "50m"
            }
          }
        }
      }
    }
  }
}
resource "helm_release" "cert-manager" {
  #depends_on   = [module.gke-cluster]  
  
  name = "cert-manager"

  #repository = "https://artifacthub.io/packages/search?org=cert-manager"
  chart      = "cert-manager/cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "version"
    value = "1.10.1"
  }

  set {
    name = "verify"
    value = false
  }
}
#####################################################################################
resource "helm_release" "nginx_ingress" {
  #depends_on   = [module.gke-cluster]  
  
  name = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
#####################################################################################
/* data "google_dns_managed_zone" "tfe" {
  name = var.cloud_dns_managed_zone
}

resource "google_dns_record_set" "app2" {
  managed_zone = data.google_dns_managed_zone.tfe[0].name
  name         = "${local.app2_fqdn}."
  type         = "A"
  ttl          = 60
  rrdatas      = [google_compute_address.tfe_frontend_lb.address]
} */

resource "helm_release" "app2" {
  #depends_on   = [module.gke-cluster]  
  
  name = "app2"

  #repository = "https://helm.releases.hashicorp.com"
  chart      = "hashicorp/vault"

  set {
    name  = "url"
    value = "https://${local.app2_fqdn}"
  }
}