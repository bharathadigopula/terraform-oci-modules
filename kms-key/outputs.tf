#==============================================================================
# OCI KMS KEY OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the software-protected AES-256 KMS key."
  value       = oci_kms_key.this.id
}