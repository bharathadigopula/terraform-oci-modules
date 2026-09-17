#==============================================================================
# OCI IDENTITY USER GROUP MEMBERSHIP OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the IAM user group membership."
  value       = oci_identity_user_group_membership.this.id
}