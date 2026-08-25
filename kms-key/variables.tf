#==============================================================================
# OCI KMS KEY CONFIGURATION
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the KMS key."
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.compartment\\.oc1\\.[a-z0-9.-]+$", var.compartment_id))
    error_message = "compartment_id must be a valid OCI compartment OCID."
  }
}

variable "display_name" {
  description = "Display name of the KMS key."
  type        = string

  validation {
    condition     = length(trimspace(var.display_name)) > 0
    error_message = "display_name must not be empty."
  }
}

variable "management_endpoint" {
  description = "Management endpoint of the KMS Vault that owns the key."
  type        = string

  validation {
    condition     = can(regex("^https://", var.management_endpoint))
    error_message = "management_endpoint must be an HTTPS endpoint."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to the KMS key."
  type        = map(string)
  default     = {}
}