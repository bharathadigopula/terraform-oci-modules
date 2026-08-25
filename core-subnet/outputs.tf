#==============================================================================
# OCI CORE SUBNET OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the subnet."
  value       = oci_core_subnet.this.id
}