#==============================================================================
# OBJECT STORAGE BUCKET CONFIGURATION
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the buckets."
  type        = string
}

variable "namespace" {
  description = "Object Storage namespace of the tenancy that owns the buckets."
  type        = string

  validation {
    condition     = length(trimspace(var.namespace)) > 0
    error_message = "namespace must not be empty."
  }
}

variable "buckets" {
  description = "Map of private Object Storage buckets to create."
  type = map(object({
    name       = string
    versioning = optional(string, "Disabled")
  }))

  validation {
    condition     = alltrue([for bucket in values(var.buckets) : contains(["Enabled", "Disabled"], bucket.versioning)])
    error_message = "Each bucket versioning value must be Enabled or Disabled."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to every bucket."
  type        = map(string)
  default     = {}
}
