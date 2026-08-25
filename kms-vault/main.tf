#==============================================================================
# OCI KMS VAULT
#==============================================================================

resource "oci_kms_vault" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  vault_type     = "DEFAULT"

  freeform_tags = var.freeform_tags

  lifecycle {
    prevent_destroy = true
  }
}