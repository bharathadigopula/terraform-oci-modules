# OCI VCN Module

Creates a regional VCN, public server subnet, private Bastion subnet, internet routing, and network security groups for SSH and optional public web traffic.

## Example

```hcl
module "vcn" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//vcn?ref=v0.10.1"

  compartment_id            = var.compartment_id
  resource_prefix           = "portfolio-prd-bom"
  dns_label                 = "portfolioprd"
  vcn_cidr                  = "10.42.0.0/16"
  subnet_cidr               = "10.42.10.0/24"
  bastion_subnet_cidr       = "10.42.20.0/28"
  ssh_allowed_cidr          = "203.0.113.10/32"
  public_web_ingress_enabled = false
}
```

Set `public_web_ingress_enabled` to `false` when HTTP and HTTPS are delivered through an outbound-only Cloudflare Tunnel. This removes the public `0.0.0.0/0` ingress rules for ports `80` and `443` while retaining the public web NSG output for compatibility.

## Inputs

| Name | Required | Default | Purpose |
|---|---:|---|---|
| `compartment_id` | Yes | None | Compartment OCID |
| `resource_prefix` | Yes | None | Project, environment, and region prefix |
| `dns_label` | Yes | None | Short VCN DNS label |
| `vcn_cidr` | Yes | None | VCN address range |
| `subnet_cidr` | Yes | None | Server subnet address range |
| `bastion_subnet_cidr` | Yes | None | Private Bastion subnet address range |
| `ssh_allowed_cidr` | Yes | None | Trusted SSH source |
| `public_web_ingress_enabled` | No | `true` | Create public TCP `80` and `443` ingress rules |
| `freeform_tags` | No | `{}` | Resource tags |

## Outputs

Returns the VCN, server and Bastion subnet, server NSG, and public web NSG OCIDs.
