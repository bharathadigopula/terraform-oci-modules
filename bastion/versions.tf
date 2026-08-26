#==============================================================================
# TERRAFORM AND PROVIDER REQUIREMENTS
#==============================================================================

terraform {
  required_version = ">= 1.12.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "8.28.0"
    }
  }
}