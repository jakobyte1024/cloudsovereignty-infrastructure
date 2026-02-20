resource "stackit_kms_keyring" "main" {
  project_id   = var.stackit_project_id
  region       = var.stackit_region
  display_name = "main"
}

resource "stackit_kms_key" "kek" {
  project_id   = var.stackit_project_id
  keyring_id   = stackit_kms_keyring.main.keyring_id
  display_name = "kek"
  protection   = "software"
  algorithm    = "aes_256_gcm"
  purpose      = "symmetric_encrypt_decrypt"
}