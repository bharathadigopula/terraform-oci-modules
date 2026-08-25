#==============================================================================
# RANDOM PASSWORD
#==============================================================================

resource "random_password" "this" {
  length           = var.length
  special          = true
  override_special = "_#-"
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
}