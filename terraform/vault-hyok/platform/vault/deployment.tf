resource "kubernetes_namespace_v1" "vault" {
  metadata {
    name = "vault"
  }
}

resource "kubernetes_deployment_v1" "vault" {
  metadata {
    name      = "vault"
    namespace = kubernetes_namespace_v1.vault.metadata[0].name
    labels    = { app = "vault" }
  }

  spec {
    replicas = 1
    selector {
      match_labels = { app = "vault" }
    }
    template {
      metadata {
        labels = { app = "vault" }
      }
      spec {
        container {
          name  = "vault"
          image = "hashicorp/vault:1.21.3"

          args = [
            "server",
            "-dev",
            "-dev-root-token-id=${random_password.vault_root_token.result}",
            "-dev-listen-address=0.0.0.0:8200"
          ]

          port {
            container_port = 8200
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "vault" {
  metadata {
    name      = "vault"
    namespace = kubernetes_namespace_v1.vault.metadata[0].name
  }

  spec {
    selector = {
      app = "vault"
    }
    port {
      port        = 8200
      target_port = 8200
    }

    type = "LoadBalancer"
  }

  wait_for_load_balancer = true
}