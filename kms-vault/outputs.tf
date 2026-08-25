#==============================================================================
# OCI KMS VAULT OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the KMS Vault."
  value       = oci_kms_vault.this.id
}

output "management_endpoint" {
  description = "Management endpoint of the KMS Vault."
  value       = oci_kms_vault.this.management_endpoint
}

output "crypto_endpoint" {
  description = "Cryptographic endpoint of the KMS Vault."
  value       = oci_kms_vault.this.crypto_endpoint
}