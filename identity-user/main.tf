#==============================================================================
# OCI IDENTITY USER
#==============================================================================

resource "oci_identity_user" "this" {
  compartment_id = var.tenancy_id
  description    = var.description
  email          = var.email
  name           = var.name

  freeform_tags = var.freeform_tags
}