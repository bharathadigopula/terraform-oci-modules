#==============================================================================
# OCI IDENTITY USER GROUP MEMBERSHIP
#==============================================================================

resource "oci_identity_user_group_membership" "this" {
  compartment_id = var.tenancy_id
  group_id       = var.group_id
  user_id        = var.user_id
}