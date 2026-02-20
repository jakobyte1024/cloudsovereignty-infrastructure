locals {
  vault_address = try(
    kubernetes_service_v1.vault.status[0].load_balancer[0].ingress[0].ip,
    kubernetes_service_v1.vault.status[0].load_balancer[0].ingress[0].hostname,
    "no-address-assigned"
  )
}

output "vault_token" {
  description = "The randomly generated root token"
  value       = random_password.vault_root_token.result
  sensitive   = true
}

output "vault_endpoint" {
  description = "The Vault transit engine endpoint URL"
  value       = "http://${local.vault_address}:8200/v1/transit"
}