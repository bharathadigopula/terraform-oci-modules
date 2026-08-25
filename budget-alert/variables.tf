#==============================================================================
# OCI BUDGET CONFIGURATION
#==============================================================================

variable "tenancy_id" {
  description = "OCID of the tenancy where OCI creates the budget."
  type        = string
}

variable "target_compartment_id" {
  description = "OCID of the compartment whose spending the budget tracks."
  type        = string
}

variable "name" {
  description = "Display name of the budget."
  type        = string
}

variable "description" {
  description = "Purpose of the budget."
  type        = string
}

variable "amount" {
  description = "Monthly budget amount in the tenancy billing currency."
  type        = number
  default     = 1

  validation {
    condition     = var.amount > 0
    error_message = "amount must be greater than zero."
  }
}

variable "alert_threshold_percentage" {
  description = "Percentage of the budget that triggers actual and forecast alerts."
  type        = number
  default     = 1

  validation {
    condition     = var.alert_threshold_percentage > 0 && var.alert_threshold_percentage <= 100
    error_message = "alert_threshold_percentage must be greater than zero and at most 100."
  }
}

variable "recipients" {
  description = "Comma-separated email addresses that receive budget alerts."
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.recipients)) > 0
    error_message = "recipients must not be empty."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to the budget and alert rules."
  type        = map(string)
  default     = {}
}