# OCI VCN Module 🌐

Creates a regional VCN, public subnet, internet route, and network security groups for SSH and web traffic.

## Example 🚀

```hcl
module "vcn" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//vcn?ref=v0.2.0"

  compartment_id   = var.compartment_id
  resource_prefix  = "portfolio-prd-bom"
  dns_label        = "portfolioprd"
  vcn_cidr         = "10.42.0.0/16"
  subnet_cidr      = "10.42.10.0/24"
  ssh_allowed_cidr = "203.0.113.10/32"
}
```

## Inputs 🔧

| Name | Required | Purpose |
|---|---:|---|
| `compartment_id` | Yes | Compartment OCID |
| `resource_prefix` | Yes | Project, environment, and region prefix |
| `dns_label` | Yes | Short VCN DNS label |
| `vcn_cidr` | Yes | VCN address range |
| `subnet_cidr` | Yes | Server subnet address range |
| `ssh_allowed_cidr` | Yes | Trusted SSH source |
| `freeform_tags` | No | Resource tags |

## Outputs 📤

Returns the VCN, subnet, server NSG, and public web NSG OCIDs.
