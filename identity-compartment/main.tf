#==============================================================================
# IDENTITY COMPARTMENT
#==============================================================================

resource "oci_identity_compartment" "this" {
  compartment_id = var.parent_compartment_id
  description    = var.description
  enable_delete  = var.enable_delete
  name           = var.name

  freeform_tags = var.freeform_tags
}