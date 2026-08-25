# OCI Budget Alert Module

Creates a monthly compartment budget with actual and forecast email alerts.

## Inputs

| Input | Default | Description |
|---|---|---|
| `tenancy_id` | Required | Tenancy OCID that owns the budget |
| `target_compartment_id` | Required | Compartment OCID whose spending is tracked |
| `name` | Required | Budget display name |
| `description` | Required | Budget purpose |
| `amount` | `1` | Monthly amount in the tenancy billing currency |
| `alert_threshold_percentage` | `1` | Percentage that triggers actual and forecast alerts |
| `recipients` | Required | Comma-separated alert email addresses |
| `freeform_tags` | `{}` | Tags applied to the budget and alert rules |

```hcl
module "budget_alert" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//budget-alert?ref=v0.4.0"

  tenancy_id                 = var.tenancy_ocid
  target_compartment_id      = module.identity_compartment.id
  name                       = "bharathcloudops-prd-budget"
  description                = "No-intended-cost production budget"
  amount                     = 1
  alert_threshold_percentage = 1
  recipients                 = var.budget_alert_recipients
}
```

OCI evaluates budget alerts periodically, typically every 24 hours. Budgets notify recipients but do not stop or delete resources.