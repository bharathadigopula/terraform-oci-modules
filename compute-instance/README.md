# OCI Compute Instance Module

Creates OCI Always Free Ampere A1 Flex and E2 Micro instances. Every instance supplies an exact regional image OCID so rebuilds cannot silently switch operating-system images.

## Example

```hcl
module "compute_instance" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//compute-instance?ref=v0.5.0"

  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  subnet_id           = var.subnet_id
  server_nsg_id        = var.server_nsg_id
  public_web_nsg_id    = var.public_web_nsg_id
  ssh_public_key       = var.ssh_public_key

  instances = {
    platform = {
      display_name     = "bharathcloudops-prd-hyd-platform"
      hostname_label   = "platform"
      shape            = "VM.Standard.A1.Flex"
      image_id         = "ocid1.image.oc1.ap-hyderabad-1.example"
      ocpus            = 1
      memory_in_gbs    = 6
      boot_volume_gbs  = 70
      assign_public_ip = true
      public_web       = true
      role             = "platform"
    }
  }
}
```

## Instance Fields

| Field | Required | Description |
|---|---:|---|
| `display_name` | Yes | OCI instance display name |
| `hostname_label` | Yes | VNIC hostname label |
| `shape` | Yes | `VM.Standard.A1.Flex` or `VM.Standard.E2.1.Micro` |
| `image_id` | Yes | Exact regional OCI image OCID |
| `ocpus` | A1 only | A1 OCPU allocation; omit for E2 Micro |
| `memory_in_gbs` | A1 only | A1 memory allocation; omit for E2 Micro |
| `boot_volume_gbs` | Yes | Boot volume size, minimum 50 GB |
| `assign_public_ip` | Yes | Assign an ephemeral public IPv4 address |
| `public_web` | Yes | Attach the public web NSG |
| `role` | Yes | Value applied to instance metadata and tags |

## Guardrails

| Resource | Maximum |
|---|---:|
| A1 instances | 2 |
| E2 Micro instances | 2 |
| Total A1 OCPUs | 2 |
| Total A1 memory | 12 GB |
| Total boot storage | 200 GB |

Use ARM64-compatible operating system packages and container images.
