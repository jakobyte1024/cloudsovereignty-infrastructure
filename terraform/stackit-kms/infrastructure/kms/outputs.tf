output "keyring_id" {
  value = stackit_kms_keyring.main.keyring_id
}

output "key_id" {
  value = stackit_kms_key.kek.key_id
}