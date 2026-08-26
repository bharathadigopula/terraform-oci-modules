#==============================================================================
# RESOURCE IDENTITY
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the bastion."
  type        = string
}

variable "name" {
  description = "Name of the bastion."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{1,64}$", var.name))
    error_message = "name must contain 1-64 alphanumeric characters."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to the bastion."
  type        = map(string)
  default     = {}
}

#==============================================================================
# ACCESS CONFIGURATION
#==============================================================================

variable "target_subnet_id" {
  description = "OCID of the subnet containing the bastion targets."
  type        = string
}

variable "client_cidr_block_allow_list" {
  description = "Restricted client CIDR blocks permitted to connect to bastion sessions."
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr_block in var.client_cidr_block_allow_list :
      can(cidrhost(cidr_block, 0)) && cidr_block != "0.0.0.0/0"
    ])
    error_message = "client_cidr_block_allow_list must contain valid restricted CIDRs."
  }
}

variable "max_session_ttl_in_seconds" {
  description = "Maximum lifetime of a bastion session."
  type        = number
  default     = 1800

  validation {
    condition     = var.max_session_ttl_in_seconds >= 1800 && var.max_session_ttl_in_seconds <= 10800
    error_message = "max_session_ttl_in_seconds must be between 1800 and 10800 seconds."
  }
}