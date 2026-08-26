#==============================================================================
# OCI BASTION
#==============================================================================

resource "oci_bastion_bastion" "this" {
  bastion_type                 = "STANDARD"
  client_cidr_block_allow_list = var.client_cidr_block_allow_list
  compartment_id               = var.compartment_id
  max_session_ttl_in_seconds   = var.max_session_ttl_in_seconds
  name                         = var.name
  target_subnet_id             = var.target_subnet_id

  freeform_tags = var.freeform_tags
}