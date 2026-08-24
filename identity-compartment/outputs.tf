#==============================================================================
# IDENTITY COMPARTMENT OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the compartment."
  value       = oci_identity_compartment.this.id
}

output "name" {
  description = "Name of the compartment."
  value       = oci_identity_compartment.this.name
}