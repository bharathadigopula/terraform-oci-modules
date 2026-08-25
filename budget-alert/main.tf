#==============================================================================
# COMPARTMENT BUDGET
#==============================================================================

resource "oci_budget_budget" "this" {
  compartment_id = var.tenancy_id
  amount         = var.amount
  reset_period   = "MONTHLY"
  target_type    = "COMPARTMENT"
  targets        = [var.target_compartment_id]
  display_name   = var.name
  description    = var.description

  freeform_tags = var.freeform_tags
}

#==============================================================================
# ACTUAL AND FORECAST ALERTS
#==============================================================================

resource "oci_budget_alert_rule" "actual" {
  budget_id      = oci_budget_budget.this.id
  display_name   = "${var.name}-actual"
  description    = "Alert when actual spend reaches the configured threshold."
  message        = "Actual OCI spend has crossed the no-intended-cost threshold."
  recipients     = var.recipients
  threshold      = var.alert_threshold_percentage
  threshold_type = "PERCENTAGE"
  type           = "ACTUAL"

  freeform_tags = var.freeform_tags
}

resource "oci_budget_alert_rule" "forecast" {
  budget_id      = oci_budget_budget.this.id
  display_name   = "${var.name}-forecast"
  description    = "Alert when forecast spend reaches the configured threshold."
  message        = "Forecast OCI spend has crossed the no-intended-cost threshold."
  recipients     = var.recipients
  threshold      = var.alert_threshold_percentage
  threshold_type = "PERCENTAGE"
  type           = "FORECAST"

  freeform_tags = var.freeform_tags
}