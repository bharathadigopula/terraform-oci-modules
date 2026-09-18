#==============================================================================
# OCI IDENTITY GROUP OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the IAM group."
  value       = oci_identity_group.this.id
}

output "name" {
  description = "Name of the IAM group."
  value       = oci_identity_group.this.name
}