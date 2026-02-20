provider "kubernetes" {
  config_path = "${path.root}/../kubeconfig-local.yaml"
}

resource "random_password" "vault_root_token" {
  length  = 32
  special = false
}