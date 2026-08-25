#==============================================================================
# OCI CORE SECURITY LIST OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the security list."
  value       = oci_core_security_list.this.id
}