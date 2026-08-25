#==============================================================================
# OCI CORE SECURITY LIST
#==============================================================================

resource "oci_core_security_list" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  vcn_id         = var.vcn_id

  dynamic "egress_security_rules" {
    for_each = var.egress_rules

    content {
      destination      = egress_security_rules.value.destination
      destination_type = egress_security_rules.value.destination_type
      protocol         = egress_security_rules.value.protocol
      stateless        = egress_security_rules.value.stateless
    }
  }

  freeform_tags = var.freeform_tags
}