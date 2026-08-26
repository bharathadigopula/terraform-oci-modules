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

variable "enabled_agent_plugins" {
  description = "Oracle Cloud Agent plugins explicitly enabled on every compute instance."
  type        = set(string)
  default     = []

  validation {
    condition     = alltrue([for plugin_name in var.enabled_agent_plugins : length(trimspace(plugin_name)) > 0])
    error_message = "enabled_agent_plugins cannot contain empty plugin names."
  }
}

variable "ssh_public_key" {
  description = "OpenSSH public key installed on every compute instance."
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^(ssh-(rsa|ed25519)|ecdsa-sha2-nistp(256|384|521)) ", var.ssh_public_key))
    error_message = "ssh_public_key must be a valid OpenSSH public key."
  }
}

variable "instances" {
  description = "Map of Always Free compute instances to create."
  type = map(object({
    display_name     = string
    hostname_label   = string
    shape            = string
    image_id         = string
    ocpus            = optional(number)
    memory_in_gbs    = optional(number)
    boot_volume_gbs  = number
    assign_public_ip = bool
    public_web       = bool
    role             = string
  }))

  validation {
    condition     = length(var.instances) <= 4
    error_message = "Always Free supports at most four instances across Ampere A1 and E2 Micro shapes."
  }

  validation {
    condition = alltrue([
      for instance in values(var.instances) :
      contains(["VM.Standard.A1.Flex", "VM.Standard.E2.1.Micro"], instance.shape)
    ])
    error_message = "Each instance must use VM.Standard.A1.Flex or VM.Standard.E2.1.Micro."
  }

  validation {
    condition = alltrue([
      for instance in values(var.instances) :
      can(regex("^ocid1\\.image\\.oc1\\.[a-z0-9.-]+$", instance.image_id))
    ])
    error_message = "Each image_id must be a valid OCI image OCID."
  }

  validation {
    condition = length([
      for instance in values(var.instances) : instance
      if instance.shape == "VM.Standard.A1.Flex"
    ]) <= 2
    error_message = "Always Free supports at most two Ampere A1 instances."
  }

  validation {
    condition = length([
      for instance in values(var.instances) : instance
      if instance.shape == "VM.Standard.E2.1.Micro"
    ]) <= 2
    error_message = "Always Free supports at most two E2 Micro instances."
  }

  validation {
    condition = alltrue([
      for instance in values(var.instances) :
      instance.shape == "VM.Standard.A1.Flex" ? (
        instance.ocpus != null && instance.memory_in_gbs != null
        ) : (
        instance.ocpus == null && instance.memory_in_gbs == null
      )
    ])
    error_message = "Ampere A1 instances require ocpus and memory_in_gbs; E2 Micro instances must omit them."
  }

  validation {
    condition = sum([
      for instance in values(var.instances) : instance.ocpus
      if instance.shape == "VM.Standard.A1.Flex"
    ]) <= 2
    error_message = "Combined Ampere A1 OCPUs cannot exceed the Always Free limit of 2."
  }

  validation {
    condition = sum([
      for instance in values(var.instances) : instance.memory_in_gbs
      if instance.shape == "VM.Standard.A1.Flex"
    ]) <= 12
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
