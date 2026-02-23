module "vault" {
  source = "./vault"
}

module "apps" {
  source = "./apps"
  encryptionproxy_endpoint = module.vault.encryptionproxy_endpoint
}