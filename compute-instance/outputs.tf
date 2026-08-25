#==============================================================================
# COMPUTE INSTANCE OUTPUTS
#==============================================================================

output "instances" {
  description = "Connection and identity details for every compute instance."
  value = {
    for name, instance in oci_core_instance.this : name => {
      id                  = instance.id
      private_ip          = instance.private_ip
      public_ip           = instance.public_ip
      reserved_private_ip = try(oci_core_private_ip.reserved_public[name].ip_address, null)
      reserved_public_ip  = try(oci_core_public_ip.reserved[name].ip_address, null)
      shape               = instance.shape
    }
  }
}
