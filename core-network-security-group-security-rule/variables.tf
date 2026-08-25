#==============================================================================
# OCI CORE NETWORK SECURITY GROUP SECURITY RULE CONFIGURATION
#==============================================================================

variable "network_security_group_id" {
  description = "OCID of the network security group that owns the rule."
  type        = string
}

variable "direction" {
  description = "Traffic direction for the rule."
  type        = string

  validation {
    condition     = contains(["INGRESS", "EGRESS"], var.direction)
    error_message = "direction must be INGRESS or EGRESS."
  }
}

variable "protocol" {
  description = "IP protocol number used by the rule."
  type        = string
}

variable "traffic_source" {
  description = "Source CIDR or network security group OCID for ingress traffic."
  type        = string
}

variable "source_type" {
  description = "Type of source used by the ingress rule."
  type        = string

  validation {
    condition     = contains(["CIDR_BLOCK", "NETWORK_SECURITY_GROUP", "SERVICE_CIDR_BLOCK"], var.source_type)
    error_message = "source_type must be CIDR_BLOCK, NETWORK_SECURITY_GROUP, or SERVICE_CIDR_BLOCK."
  }
}

variable "tcp_destination_port" {
  description = "Optional TCP destination port permitted by the rule."
  type        = number
  default     = null

  validation {
    condition     = var.tcp_destination_port == null || (var.tcp_destination_port >= 1 && var.tcp_destination_port <= 65535)
    error_message = "tcp_destination_port must be between 1 and 65535."
  }
}

variable "stateless" {
  description = "Whether the rule is stateless."
  type        = bool
  default     = false
}