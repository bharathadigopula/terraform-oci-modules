#==============================================================================
# OCI VAULT SECRET CONFIGURATION
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the secret."
  type        = string
}

variable "key_id" {
  description = "OCID of the symmetric KMS key that encrypts the secret."
  type        = string
}

variable "secret_name" {
  description = "Unique name of the secret within the Vault."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9._-]+$", var.secret_name))
    error_message = "secret_name may contain only letters, numbers, periods, underscores, and hyphens."
  }
}

variable "secret_content" {
  description = "Plaintext content encrypted into the Vault secret."
  type        = string
  sensitive   = true
}

variable "vault_id" {
  description = "OCID of the Vault that contains the secret."
  type        = string
}

variable "freeform_tags" {
  description = "Free-form tags applied to the secret."
  type        = map(string)
  default     = {}
}