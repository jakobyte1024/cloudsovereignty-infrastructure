locals {
  workspace_root = "${path.root}/../../../.."
}

data "terraform_remote_state" "infrastructure" {
  backend = "local"
  config = {
    path = "${path.root}/../infrastructure/terraform.tfstate"
  }
}

provider "kubernetes" {
  config_path = "${path.root}/../kubeconfig-main.yaml"
}

provider "helm" {
  kubernetes = {
    config_path = "${path.root}/../kubeconfig-main.yaml"
  }
}

