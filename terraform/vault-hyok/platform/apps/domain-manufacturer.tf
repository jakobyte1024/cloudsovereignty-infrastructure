resource "helm_release" "manufacturer_domain" {
  name             = "manufacturerdomain"
  namespace        = "default"
  chart            = "${local.workspace_root}/cloudsovereignty-manufacturerdomain/resources/k8s"
  create_namespace = true
  wait             = true

  values = [
    file("${local.workspace_root}/cloudsovereignty-manufacturerdomain/resources/k8s/values.yaml")
  ]

  set_sensitive = [
    {
      name  = "app.dbconfig.user"
      value = data.terraform_remote_state.infrastructure.outputs.manufacturer_dbuser
    },
    {
      name  = "app.dbconfig.password"
      value = data.terraform_remote_state.infrastructure.outputs.manufacturer_dbpassword
    }
  ]

  set = [
    {
      name  = "app.image.tag"
      value = "latest"
    },
    {
      name  = "app.dbconfig.host"
      value = data.terraform_remote_state.infrastructure.outputs.dbhost
    },
    {
      name  = "app.dbconfig.port"
      value = data.terraform_remote_state.infrastructure.outputs.dbport
      type  = "string" # needed to ensure port is treated as string
    },
    {
      name  = "app.dbconfig.schema"
      value = "public"
    },
    {
      name  = "app.dbconfig.name"
      value = data.terraform_remote_state.infrastructure.outputs.manufacturer_dbname
    },
    {
      name  = "app.appconfig.ENCRYPTIONPROXY_ENCRYPTION_URL"
      value = "http://encryptionproxy-service/api/v1/encrypt"
    },
    {
      name  = "app.appconfig.ENCRYPTIONPROXY_DECRYPTION_URL"
      value = "http://encryptionproxy-service/api/v1/decrypt"
    },
    {
      name  = "app.appconfig.KEK_PROVIDER_BOM"
      value = "vault"
    },
    {
      name  = "app.appconfig.KEK_KEYNAME_BOM"
      value = "kek"
    }
  ]
}
