#==============================================================================
# OBJECT STORAGE BUCKET OUTPUTS
#==============================================================================

output "buckets" {
  description = "Names and namespaces for every Object Storage bucket."
  value = {
    for name, bucket in oci_objectstorage_bucket.this : name => {
      name      = bucket.name
      namespace = bucket.namespace
    }
  }
}
