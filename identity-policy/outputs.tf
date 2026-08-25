#==============================================================================
# OCI IDENTITY POLICY OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the IAM policy."
  value       = oci_identity_policy.this.id
}