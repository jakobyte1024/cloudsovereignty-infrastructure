resource "helm_release" "encryption_proxy" {
  name             = "encryptionproxy"
  namespace        = "default"
  chart            = "${local.workspace_root}/cloudsovereignty-encryptionproxy/helm"
  create_namespace = true
  wait             = true

  values = [
    file("${local.workspace_root}/cloudsovereignty-encryptionproxy/helm/values.yaml"),
  ]

  set = [
    {
      name  = "app.image.tag"
      value = "latest"
    },
    {
      name  = "app.encryptionproviders.vault.enabled"
      value = true
    },
    {
      name  = "app.encryptionproviders.vault.config.ENDPOINT"
      value = local.vault_endpoint
    },
    {
      name  = "app.encryptionproviders.vault.config.TOKEN"
      value = local.vault_token
    },
    {
      name  = "app.appconfig.enableLoadBalancerService"
      value = false
    }
  ]
}

resource "kubernetes_service_v1" "encryption_proxy_lbl" {
  metadata {
    name      = "${helm_release.encryption_proxy.name}-lbl-service"
    namespace = helm_release.encryption_proxy.namespace
  }

  spec {
    selector = {
      "app.kubernetes.io/name"     = "encryptionproxy"
      "app.kubernetes.io/instance" = helm_release.encryption_proxy.name
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }

  wait_for_load_balancer = true

  depends_on = [
    helm_release.encryption_proxy
  ]
}
