#==============================================================================
# OCI MYSQL DB SYSTEM OUTPUTS
#==============================================================================

output "id" {
  description = "OCID of the MySQL DB system."
  value       = oci_mysql_mysql_db_system.this.id
}

output "endpoints" {
  description = "Private endpoints exposed by the MySQL DB system."
  value       = oci_mysql_mysql_db_system.this.endpoints
}

output "ip_address" {
  description = "Private IP address of the MySQL DB system."
  value       = oci_mysql_mysql_db_system.this.ip_address
}

output "mysql_version" {
  description = "MySQL version running on the DB system."
  value       = oci_mysql_mysql_db_system.this.mysql_version
}

output "state" {
  description = "Lifecycle state of the MySQL DB system."
  value       = oci_mysql_mysql_db_system.this.state
}