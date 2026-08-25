#==============================================================================
# OCI MYSQL DB SYSTEM CONFIGURATION
#==============================================================================

variable "admin_password" {
  description = "Administrator password for the DB system."
  type        = string
  sensitive   = true
}

variable "admin_username" {
  description = "Administrator username for the DB system."
  type        = string
  default     = "mysqladmin"

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9_]{0,31}$", var.admin_username)) && lower(var.admin_username) != "root"
    error_message = "admin_username must be 1-32 letters, numbers, or underscores, start with a letter, and cannot be root."
  }
}

variable "availability_domain" {
  description = "Availability domain that hosts the DB system."
  type        = string
}

variable "compartment_id" {
  description = "OCID of the compartment that owns the DB system."
  type        = string
}

variable "display_name" {
  description = "Display name of the DB system."
  type        = string
}

variable "hostname_label" {
  description = "DNS hostname label assigned to the DB system."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,62}$", var.hostname_label))
    error_message = "hostname_label must start with a lowercase letter and contain only lowercase letters, numbers, or hyphens."
  }
}

variable "subnet_id" {
  description = "OCID of the private subnet that hosts the DB system."
  type        = string
}

variable "nsg_ids" {
  description = "OCIDs of network security groups assigned to the DB system."
  type        = set(string)

  validation {
    condition     = length(var.nsg_ids) > 0
    error_message = "At least one network security group must be assigned to the DB system."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to the DB system."
  type        = map(string)
  default     = {}
}