# Terraform Infrastructure Modules

Small Terraform modules for Oracle Cloud Infrastructure and Cloudflare Zero Trust. Each folder is named after the resource group it manages.

## Available Modules

| Folder | Managed resources |
|---|---|
| `budget-alert` | Monthly compartment budget with actual and forecast email alerts |
| `cloudflare-access-tunnel` | Cloudflare Tunnel, proxied DNS, email one-time PIN identity provider, Access policy, and self-hosted applications |
| `compute-instance` | Ampere A1 Flex and E2 Micro compute instances with pinned images and boot-volume limits |
| `core-network-security-group` | Network security group |
| `core-network-security-group-security-rule` | Network security group security rule |
| `core-security-list` | Security list |
| `core-subnet` | Private or public subnet |
| `identity-dynamic-group` | Identity dynamic group |
| `identity-compartment` | Identity compartment |
| `identity-policy` | Identity policy |
| `kms-key` | Software-protected symmetric KMS key |
| `kms-vault` | Default OCI KMS vault |
| `mysql-db-system` | Always Free MySQL DB system |
| `object-storage-bucket` | Private Object Storage buckets |
| `random-password` | Constrained generated password |
| `vault-secret` | KMS-encrypted Vault secret |
| `vcn` | Existing VCN, subnet, internet gateway, route table, and network security groups |

## Using a Module

Pin every module to a release tag:

```hcl
module "vcn" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//vcn?ref=v0.10.1"
}
```

Each new resource-specific folder owns one Terraform resource. The legacy `vcn` module remains grouped to avoid migrating existing Terraform state.

## Shared Validation

Pull requests and pushes call the shared validation workflow from `github-pipeline-templates` release `v0.1.0`. It checks formatting, initialises with the backend disabled, and validates every module without cloud credentials. It never runs `terraform plan` or `terraform apply`.

## Local Checks

Run the checks from the module folder:

```shell
terraform fmt -check
terraform init -backend=false
terraform validate
```
