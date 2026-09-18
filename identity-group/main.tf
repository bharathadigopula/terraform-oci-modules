#==============================================================================
# OCI IDENTITY GROUP
#==============================================================================

resource "oci_identity_group" "this" {
  compartment_id = var.tenancy_id
  description    = var.description
  name           = var.name

  freeform_tags = var.freeform_tags
}