#==============================================================================
# OCI IDENTITY CUSTOMER SECRET KEY OUTPUTS
#==============================================================================

output "id" {
  description = "S3-compatible access key identifier."
  value       = oci_identity_customer_secret_key.this.id
  sensitive   = true
}

output "key" {
  description = "S3-compatible secret access key."
  value       = oci_identity_customer_secret_key.this.key
  sensitive   = true
}