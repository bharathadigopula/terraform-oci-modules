#==============================================================================
# OCI CORE NETWORK SECURITY GROUP CONFIGURATION
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the network security group."
  type        = string
}

variable "vcn_id" {
  description = "OCID of the VCN that contains the network security group."
  type        = string
}

variable "display_name" {
  description = "Display name of the network security group."
  type        = string
}

variable "freeform_tags" {
  description = "Free-form tags applied to the network security group."
  type        = map(string)
  default     = {}
}