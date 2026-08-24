#==============================================================================
# IDENTITY COMPARTMENT CONFIGURATION
#==============================================================================

variable "parent_compartment_id" {
  description = "OCID of the parent compartment or tenancy."
  type        = string
}

variable "name" {
  description = "Name of the compartment."
  type        = string
}

variable "description" {
  description = "Purpose of the compartment."
  type        = string
}

variable "enable_delete" {
  description = "Allow Terraform to delete the compartment."
  type        = bool
  default     = false
}

variable "freeform_tags" {
  description = "Free-form tags applied to the compartment."
  type        = map(string)
  default     = {}
}