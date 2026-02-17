variable "stackit_region" {
    description = "STACKIT region"
    type        = string
}

variable "stackit_project_id" {
    description = "STACKIT Project ID"
    type        = string
}

variable "import" {
    description = "If Keyring and Key should be imported"
    type = bool
}