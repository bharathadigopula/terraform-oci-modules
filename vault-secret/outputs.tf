#==============================================================================
# OCI VAULT SECRET OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the Vault secret."
  value       = oci_vault_secret.this.id
}

output "state" {
  description = "Lifecycle state of the Vault secret."
  value       = oci_vault_secret.this.state
}