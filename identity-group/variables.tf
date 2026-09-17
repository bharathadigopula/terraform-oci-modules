#==============================================================================
# OCI IDENTITY GROUP CONFIGURATION
#==============================================================================

variable "tenancy_id" {
  description = "OCID of the tenancy that owns the IAM group."
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.tenancy\\.oc1\\.[a-z0-9.-]+$", var.tenancy_id))
    error_message = "tenancy_id must be a valid OCI tenancy OCID."
  }
}

variable "name" {
  description = "Unique name of the IAM group."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9_.-]{0,99}$", var.name))
    error_message = "name must start with a letter and contain at most 100 letters, numbers, underscores, periods, or hyphens."
  }
}

variable "description" {
  description = "Description of the IAM group."
  type        = string

  validation {
    condition     = length(trimspace(var.description)) > 0
    error_message = "description must not be empty."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to the IAM group."
  type        = map(string)
  default     = {}
}