# OCI Identity Compartment Module 🧭

Creates an OCI compartment for an isolated workload or environment.

## Example 🚀

```hcl
module "identity_compartment" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//identity-compartment?ref=v0.1.0"

  parent_compartment_id = var.tenancy_ocid
  name                  = "portfolio-prd"
  description           = "Production portfolio resources"
}
```

## Safety 🔒

Compartment deletion is disabled by default. Set `enable_delete = true` only when deliberate removal is required.