#==============================================================================
# OCI BUDGET OUTPUTS
#==============================================================================

output "budget_id" {
  description = "OCID of the budget."
  value       = oci_budget_budget.this.id
}

output "alert_rule_ids" {
  description = "OCIDs of the actual and forecast alert rules."
  value = {
    actual   = oci_budget_alert_rule.actual.id
    forecast = oci_budget_alert_rule.forecast.id
  }
}