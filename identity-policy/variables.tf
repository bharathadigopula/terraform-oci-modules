#==============================================================================
# OCI IDENTITY POLICY CONFIGURATION
#==============================================================================

variable "compartment_id" {
  description = "OCID of the tenancy or compartment that owns the policy."
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.(tenancy|compartment)\\.oc1\\.[a-z0-9.-]+$", var.compartment_id))
    error_message = "compartment_id must be a valid OCI tenancy or compartment OCID."
  }
}

variable "name" {
  description = "Unique name of the IAM policy."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9_.-]{0,99}$", var.name))
    error_message = "name must start with a letter and contain at most 100 letters, numbers, underscores, periods, or hyphens."
  }
}

variable "description" {
  description = "Description of the IAM policy."
  type        = string

  validation {
    condition     = length(trimspace(var.description)) > 0
    error_message = "description must not be empty."
  }
}

variable "statements" {
  description = "OCI IAM policy statements."
  type        = list(string)

  validation {
    condition = (
      length(var.statements) > 0 &&
      alltrue([for statement in var.statements : length(trimspace(statement)) > 0])
    )
    error_message = "statements must contain at least one non-empty OCI IAM policy statement."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to the IAM policy."
  type        = map(string)
  default     = {}
}