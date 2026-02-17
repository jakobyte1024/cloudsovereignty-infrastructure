resource "helm_release" "encryption_proxy" {
  name             = "encryptionproxy"
  namespace        = "default"
  chart            = "${local.workspace_root}/cloudsovereignty-encryptionproxy/helm"
  create_namespace = true
  wait             = true

  values = [
    file("${local.workspace_root}/cloudsovereignty-encryptionproxy/helm/values.yaml"),

    sensitive(yamlencode({
      app = {
        encryptionproviders = {
          stackit = {
            config = {
              SERVICEACCOUNT = file("${path.root}/../../../sa-key.json")
            }
          }
        }
      }
    }))
  ]

  set = [
    {
      name  = "app.image.tag"
      value = "latest"
    },
    {
      name  = "app.encryptionproviders.stackit.enabled"
      value = true
    },
    {
      name  = "app.encryptionproviders.stackit.config.PROJECTID"
      value = data.terraform_remote_state.infrastructure.outputs.stackit_project_id
    },
    {
      name  = "app.encryptionproviders.stackit.config.REGIONID"
      value = data.terraform_remote_state.infrastructure.outputs.stackit_region
    },
    {
      name  = "app.encryptionproviders.stackit.config.KEYRINGID"
      value = data.terraform_remote_state.infrastructure.outputs.keyring_id
    }
  ]
}