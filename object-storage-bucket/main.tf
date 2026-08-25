#==============================================================================
# PRIVATE OBJECT STORAGE BUCKETS
#==============================================================================

resource "oci_objectstorage_bucket" "this" {
  for_each = var.buckets

  compartment_id = var.compartment_id
  name           = each.value.name
  namespace      = var.namespace
  access_type    = "NoPublicAccess"
  storage_tier   = "Standard"
  versioning     = each.value.versioning

  freeform_tags = var.freeform_tags
}
