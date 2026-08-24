#==============================================================================
# COMPUTE INSTANCE OUTPUTS
#==============================================================================

output "instances" {
  description = "Connection and identity details for every compute instance."
  value = {
    for name, instance in oci_core_instance.this : name => {
      id         = instance.id
      private_ip = instance.private_ip
      public_ip  = instance.public_ip
      shape      = instance.shape
    }
  }
}
