#==============================================================================
# RESOURCE IDENTITY
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the network resources."
  type        = string
}

variable "resource_prefix" {
  description = "Project, environment, and region prefix used in display names."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,39}$", var.resource_prefix))
    error_message = "resource_prefix must contain 3-40 lowercase letters, numbers, or hyphens and start with a letter."
  }
}

variable "dns_label" {
  description = "Short DNS label used by the VCN."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9]{0,14}$", var.dns_label))
    error_message = "dns_label must start with a letter and contain at most 15 lowercase letters or numbers."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to every network resource."
  type        = map(string)
  default     = {}
}

#==============================================================================
# NETWORK ADDRESSING
#==============================================================================

variable "vcn_cidr" {
  description = "CIDR allocated to the VCN."
  type        = string

  validation {
    condition     = can(cidrhost(var.vcn_cidr, 0))
    error_message = "vcn_cidr must be a valid CIDR."
  }
}

variable "subnet_cidr" {
  description = "CIDR allocated to the server subnet."
  type        = string

  validation {
    condition     = can(cidrhost(var.subnet_cidr, 0))
    error_message = "subnet_cidr must be a valid CIDR."
  }
}

variable "bastion_subnet_cidr" {
  description = "CIDR allocated to the private Bastion subnet."
  type        = string

  validation {
    condition     = can(cidrhost(var.bastion_subnet_cidr, 0))
    error_message = "bastion_subnet_cidr must be a valid CIDR."
  }
}

variable "ssh_allowed_cidr" {
  description = "Trusted public IPv4 CIDR allowed to connect over SSH."
  type        = string

  validation {
    condition     = can(cidrhost(var.ssh_allowed_cidr, 0)) && var.ssh_allowed_cidr != "0.0.0.0/0"
    error_message = "ssh_allowed_cidr must be a valid restricted CIDR and cannot be 0.0.0.0/0."
  }
}

variable "public_web_ingress_enabled" {
  description = "Whether the public web NSG accepts HTTP and HTTPS directly from the internet."
  type        = bool
  default     = true
}
