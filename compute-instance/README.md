# OCI Compute Instance Module 🖥️

Creates one or two Ubuntu ARM instances with the Ampere A1 Flex shape. Input checks protect the current Always Free CPU, memory, instance, and boot storage limits.

## Example 🚀

```hcl
module "compute_instance" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//compute-instance?ref=v0.1.0"

  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  subnet_id           = var.subnet_id
  server_nsg_id        = var.server_nsg_id
  public_web_nsg_id    = var.public_web_nsg_id
  ssh_public_key       = var.ssh_public_key

  instances = {
    cicd = {
      display_name     = "portfolio-prd-bom-cicd-vm"
      hostname_label   = "cicd"
      ocpus            = 1
      memory_in_gbs    = 6
      boot_volume_gbs  = 100
      assign_public_ip = true
      public_web       = true
      role             = "cicd"
    }
  }
}
```

## Guardrails 🛡️

| Resource | Maximum |
|---|---:|
| A1 instances | 2 |
| Total OCPUs | 2 |
| Total memory | 12 GB |
| Total boot storage | 200 GB |

Use ARM64-compatible operating system packages and container images.
