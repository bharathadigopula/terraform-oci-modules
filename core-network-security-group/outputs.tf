#==============================================================================
# OCI CORE NETWORK SECURITY GROUP OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the network security group."
  value       = oci_core_network_security_group.this.id
}