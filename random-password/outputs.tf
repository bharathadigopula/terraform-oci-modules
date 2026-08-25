#==============================================================================
# RANDOM PASSWORD OUTPUTS
#==============================================================================

output "result" {
  description = "Generated password."
  value       = random_password.this.result
  sensitive   = true
}