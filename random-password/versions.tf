#==============================================================================
# TERRAFORM PROVIDER REQUIREMENTS
#==============================================================================

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.2, < 4.0.0"
    }
  }
}