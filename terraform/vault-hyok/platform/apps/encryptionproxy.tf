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
      value = var.vault_endpoint
    },
    {
      name  = "app.encryptionproviders.vault.config.TOKEN"
      value = var.vault_token
    },
  ]
}
