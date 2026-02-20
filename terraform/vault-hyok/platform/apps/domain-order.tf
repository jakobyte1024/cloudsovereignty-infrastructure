resource "helm_release" "order_domain" {
  name             = "orderdomain"
  namespace        = "default"
  chart            = "${local.workspace_root}/cloudsovereignty-orderdomain/resources/k8s"
  create_namespace = true
  wait             = true

  values = [
    file("${local.workspace_root}/cloudsovereignty-orderdomain/resources/k8s/values.yaml")
  ]

  set_sensitive = [
    {
      name  = "app.dbconfig.user"
      value = data.terraform_remote_state.infrastructure.outputs.order_dbuser
    },
    {
      name  = "app.dbconfig.password"
      value = data.terraform_remote_state.infrastructure.outputs.order_dbpassword
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
      value = data.terraform_remote_state.infrastructure.outputs.order_dbname
    }
  ]
}
