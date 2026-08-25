#==============================================================================
# OCI KMS VAULT CONFIGURATION
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the KMS Vault."
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.compartment\\.oc1\\.[a-z0-9.-]+$", var.compartment_id))
    error_message = "compartment_id must be a valid OCI compartment OCID."
  }
}

variable "display_name" {
  description = "Display name of the KMS Vault."
  type        = string

  validation {
    condition     = length(trimspace(var.display_name)) > 0
    error_message = "display_name must not be empty."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to the KMS Vault."
  type        = map(string)
  default     = {}
}