# OCI Terraform Modules ☁️

Small Terraform modules for Oracle Cloud Infrastructure. Each folder is named after the OCI resource it manages.

## Available Modules 📦

| Folder | OCI resources |
|---|---|
| `identity-compartment` | Identity compartment |
| `vcn` | VCN, subnet, internet gateway, route table, and network security groups |
| `compute-instance` | Ampere A1 Flex compute instances and boot volumes |
| `object-storage-bucket` | Private Object Storage buckets |

## Using a Module 🚀

Pin every module to a release tag:

```hcl
module "vcn" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//vcn?ref=v0.3.0"
}
```

## Shared Validation 🔍

Pull requests and pushes call the shared validation workflow from `github-pipeline-templates` release `v0.1.0`. It checks formatting, initialises with the backend disabled, and validates each module without OCI credentials. It never runs `terraform plan` or `terraform apply`.

## Local Checks ✅

Run the checks from the module folder:

```shell
terraform fmt -check
terraform init -backend=false
terraform validate
```
