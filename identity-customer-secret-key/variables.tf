#==============================================================================
# OCI IDENTITY CUSTOMER SECRET KEY CONFIGURATION
#==============================================================================

variable "user_id" {
  description = "OCID of the IAM user that owns the customer secret key."
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.user\\.oc1\\.[a-z0-9.-]+$", var.user_id))
    error_message = "user_id must be a valid OCI user OCID."
  }
}

variable "display_name" {
  description = "Display name of the customer secret key."
  type        = string

  validation {
    condition     = length(trimspace(var.display_name)) > 0
    error_message = "display_name must not be empty."
  }
}