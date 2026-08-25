#==============================================================================
# OCI CORE NETWORK SECURITY GROUP
#==============================================================================

resource "oci_core_network_security_group" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  vcn_id         = var.vcn_id

  freeform_tags = var.freeform_tags
}