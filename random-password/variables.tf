#==============================================================================
# RANDOM PASSWORD CONFIGURATION
#==============================================================================

variable "length" {
  description = "Length of the generated password."
  type        = number
  default     = 24

  validation {
    condition     = var.length >= 16 && var.length <= 32
    error_message = "length must be between 16 and 32 characters."
  }
}