#==============================================================================
# OCI CORE NETWORK SECURITY GROUP SECURITY RULE OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the network security group security rule."
  value       = oci_core_network_security_group_security_rule.this.id
}