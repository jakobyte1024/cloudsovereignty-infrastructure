module "vault" {
  source = "./vault"
}

module "apps" {
  source = "./apps"
  vault_endpoint = module.vault.vault_endpoint
  vault_token = module.vault.vault_token
}