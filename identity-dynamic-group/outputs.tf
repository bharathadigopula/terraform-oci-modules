#==============================================================================
# OCI IDENTITY DYNAMIC GROUP OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the dynamic group."
  value       = oci_identity_dynamic_group.this.id
}

output "name" {
  description = "Name of the dynamic group."
  value       = oci_identity_dynamic_group.this.name
}