#==============================================================================
# RESOURCE IDENTITY
#==============================================================================

variable "compartment_id" {
  description = "OCID of the compartment that owns the compute instances."
  type        = string
}

variable "availability_domain" {
  description = "Availability domain used for every compute instance."
  type        = string
}

variable "freeform_tags" {
  description = "Free-form tags applied to every compute instance."
  type        = map(string)
  default     = {}
}

#==============================================================================
# NETWORK CONFIGURATION
#==============================================================================

variable "subnet_id" {
  description = "OCID of the subnet used by the compute instances."
  type        = string
}

variable "server_nsg_id" {
  description = "OCID of the network security group shared by all servers."
  type        = string
}

variable "public_web_nsg_id" {
  description = "OCID of the network security group that permits HTTP and HTTPS."
  type        = string
}

#==============================================================================
# INSTANCE CONFIGURATION
#==============================================================================

variable "ssh_public_key" {
  description = "OpenSSH public key installed on every compute instance."
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^(ssh-(rsa|ed25519)|ecdsa-sha2-nistp(256|384|521)) ", var.ssh_public_key))
    error_message = "ssh_public_key must be a valid OpenSSH public key."
  }
}

variable "operating_system" {
  description = "Operating system used to find the latest compatible image."
  type        = string
  default     = "Canonical Ubuntu"
}

variable "operating_system_version" {
  description = "Operating system version used to find the latest compatible image."
  type        = string
  default     = "24.04"
}

variable "instances" {
  description = "Map of Ampere A1 compute instances to create."
  type = map(object({
    display_name     = string
    hostname_label   = string
    ocpus            = number
    memory_in_gbs    = number
    boot_volume_gbs  = number
    assign_public_ip = bool
    public_web       = bool
    role             = string
  }))

  validation {
    condition     = length(var.instances) <= 2
    error_message = "Always Free supports at most two Ampere A1 instances."
  }

  validation {
    condition     = sum([for instance in values(var.instances) : instance.ocpus]) <= 2
    error_message = "Combined Ampere A1 OCPUs cannot exceed the Always Free limit of 2."
  }

  validation {
    condition     = sum([for instance in values(var.instances) : instance.memory_in_gbs]) <= 12
    error_message = "Combined Ampere A1 memory cannot exceed the Always Free limit of 12 GB."
  }

  validation {
    condition     = sum([for instance in values(var.instances) : instance.boot_volume_gbs]) <= 200
    error_message = "Combined boot volume storage cannot exceed the Always Free limit of 200 GB."
  }

  validation {
    condition     = alltrue([for instance in values(var.instances) : instance.boot_volume_gbs >= 50])
    error_message = "Each boot volume must be at least 50 GB."
  }
}
