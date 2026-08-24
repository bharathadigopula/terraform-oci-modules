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
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//vcn?ref=v0.1.0"
}
```

## Local Checks ✅

Run the checks from the module folder:

```shell
terraform fmt -check
terraform init -backend=false
terraform validate
```
