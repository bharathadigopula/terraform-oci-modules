#==============================================================================
# OCI KMS KEY
#==============================================================================

resource "oci_kms_key" "this" {
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  management_endpoint = var.management_endpoint
  protection_mode     = "SOFTWARE"

  key_shape {
    algorithm = "AES"
    length    = 32
  }

  freeform_tags = var.freeform_tags

  lifecycle {
    prevent_destroy = true
  }
}