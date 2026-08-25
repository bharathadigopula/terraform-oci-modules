# OCI Object Storage Bucket Module 🗄️

Creates private Object Storage buckets for backups and small build artefacts.

## Example 🚀

```hcl
module "object_storage_bucket" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//object-storage-bucket?ref=v0.2.0"

  compartment_id = var.compartment_id

  buckets = {
    backups = {
      name       = "portfolio-prd-bom-backups-bucket"
      versioning = "Enabled"
    }
  }
}
```

## Free Usage Guardrail ⚠️

OCI applies the free allowance across Object Storage usage, not per bucket. Keep retention short, monitor stored data, and keep every bucket private.
