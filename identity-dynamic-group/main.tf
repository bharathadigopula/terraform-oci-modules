#==============================================================================
# OCI IDENTITY DYNAMIC GROUP
#==============================================================================

resource "oci_identity_dynamic_group" "this" {
  compartment_id = var.tenancy_id
  description    = var.description
  matching_rule  = var.matching_rule
  name           = var.name

  freeform_tags = var.freeform_tags
}