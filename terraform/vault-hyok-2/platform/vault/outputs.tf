locals {
  encryptionproxy_address = try(
    kubernetes_service_v1.encryption_proxy_lbl.status[0].load_balancer[0].ingress[0].ip,
    kubernetes_service_v1.encryption_proxy_lbl.status[0].load_balancer[0].ingress[0].hostname,
    "no-address-assigned"
  )
}

output "encryptionproxy_endpoint" {
  description = "The EncryptionProxy endpoint URL"
  value       = "http://${local.encryptionproxy_address}:80"
}