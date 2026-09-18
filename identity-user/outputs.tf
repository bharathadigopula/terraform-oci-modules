#==============================================================================
# OCI IDENTITY USER OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the IAM user."
  value       = oci_identity_user.this.id
}

output "name" {
  description = "Name of the IAM user."
  value       = oci_identity_user.this.name
}