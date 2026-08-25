#==============================================================================
# OCI VAULT SECRET
#==============================================================================

resource "oci_vault_secret" "this" {
  compartment_id = var.compartment_id
  key_id         = var.key_id
  secret_name    = var.secret_name
  vault_id       = var.vault_id

  secret_content {
    content      = base64encode(var.secret_content)
    content_type = "BASE64"
    name         = "current"
    stage        = "CURRENT"
  }

  freeform_tags = var.freeform_tags

  lifecycle {
    prevent_destroy = true
  }
}