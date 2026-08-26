#==============================================================================
# NETWORK OUTPUTS
#==============================================================================

output "vcn_id" {
  description = "OCID of the VCN."
  value       = oci_core_vcn.this.id
}

output "subnet_id" {
  description = "OCID of the server subnet."
  value       = oci_core_subnet.servers.id
}

output "bastion_subnet_id" {
  description = "OCID of the private Bastion subnet."
  value       = oci_core_subnet.bastion.id
}

output "server_nsg_id" {
  description = "OCID of the network security group shared by all servers."
  value       = oci_core_network_security_group.servers.id
}

output "public_web_nsg_id" {
  description = "OCID of the network security group that allows HTTP and HTTPS."
  value       = oci_core_network_security_group.public_web.id
}
