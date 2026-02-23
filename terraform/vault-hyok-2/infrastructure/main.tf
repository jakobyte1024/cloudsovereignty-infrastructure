provider "stackit" {
  service_account_key_path = "${path.module}/../../../sa-key.json"
}

module "database" {
  source = "./database"
  stackit_project_id = var.stackit_project_id
  stackit_region = var.stackit_region
}

module "cluster" {
  source = "./cluster"
  stackit_project_id = var.stackit_project_id
  stackit_region = var.stackit_region
}

module "vault" {
  source = "./vault"
  stackit_project_id = var.stackit_project_id
  stackit_region = var.stackit_region
}