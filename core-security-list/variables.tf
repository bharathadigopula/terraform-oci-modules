#==============================================================================
# OCI CORE SECURITY LIST CONFIGURATION
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the security list."
  type        = string
}

variable "vcn_id" {
  description = "OCID of the VCN that contains the security list."
  type        = string
}

variable "display_name" {
  description = "Display name of the security list."
  type        = string
}

variable "egress_rules" {
  description = "Egress rules applied to the security list."
  type = map(object({
    destination      = string
    destination_type = string
    protocol         = string
    stateless        = bool
  }))
  default = {}
}

variable "freeform_tags" {
  description = "Free-form tags applied to the security list."
  type        = map(string)
  default     = {}
}