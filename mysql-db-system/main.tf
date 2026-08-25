#==============================================================================
# OCI MYSQL DB SYSTEM
#==============================================================================

resource "oci_mysql_mysql_db_system" "this" {
  admin_password          = var.admin_password
  admin_username          = var.admin_username
  availability_domain     = var.availability_domain
  compartment_id          = var.compartment_id
  data_storage_size_in_gb = 50
  display_name            = var.display_name
  hostname_label          = var.hostname_label
  is_highly_available     = false
  mysql_version           = "26.7.0"
  nsg_ids                 = var.nsg_ids
  port                    = 3306
  port_x                  = 33060
  shape_name              = "MySQL.Free"
  subnet_id               = var.subnet_id

  freeform_tags = var.freeform_tags

  lifecycle {
    prevent_destroy = true
  }
}