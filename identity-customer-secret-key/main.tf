#==============================================================================
# OCI IDENTITY CUSTOMER SECRET KEY
#==============================================================================

resource "oci_identity_customer_secret_key" "this" {
  display_name = var.display_name
  user_id      = var.user_id
}