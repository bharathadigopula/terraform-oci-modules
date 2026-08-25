#==============================================================================
# OCI CORE SUBNET CONFIGURATION
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the subnet."
  type        = string
}

variable "vcn_id" {
  description = "OCID of the VCN that contains the subnet."
  type        = string
}

variable "cidr_block" {
  description = "IPv4 CIDR allocated to the subnet."
  type        = string

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "cidr_block must be a valid IPv4 CIDR."
  }
}

variable "display_name" {
  description = "Display name of the subnet."
  type        = string
}

variable "dns_label" {
  description = "DNS label of the subnet."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9]{0,14}$", var.dns_label))
    error_message = "dns_label must start with a letter and contain at most 15 lowercase letters or numbers."
  }
}

variable "prohibit_public_ip_on_vnic" {
  description = "Prevent public IP assignment to VNICs in the subnet."
  type        = bool
  default     = true
}

variable "security_list_ids" {
  description = "OCIDs of security lists assigned to the subnet."
  type        = list(string)
}

variable "freeform_tags" {
  description = "Free-form tags applied to the subnet."
  type        = map(string)
  default     = {}
}