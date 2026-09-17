#==============================================================================
# OCI IDENTITY USER GROUP MEMBERSHIP CONFIGURATION
#==============================================================================

variable "tenancy_id" {
  description = "OCID of the tenancy that owns the membership."
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.tenancy\\.oc1\\.[a-z0-9.-]+$", var.tenancy_id))
    error_message = "tenancy_id must be a valid OCI tenancy OCID."
  }
}

variable "group_id" {
  description = "OCID of the IAM group."
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.group\\.oc1\\.[a-z0-9.-]+$", var.group_id))
    error_message = "group_id must be a valid OCI group OCID."
  }
}

variable "user_id" {
  description = "OCID of the IAM user."
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.user\\.oc1\\.[a-z0-9.-]+$", var.user_id))
    error_message = "user_id must be a valid OCI user OCID."
  }
}