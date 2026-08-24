#==============================================================================
# VIRTUAL CLOUD NETWORK
#==============================================================================

resource "oci_core_vcn" "this" {
  cidr_blocks    = [var.vcn_cidr]
  compartment_id = var.compartment_id
  display_name   = "${var.resource_prefix}-vcn"
  dns_label      = var.dns_label

  freeform_tags = var.freeform_tags
}

#==============================================================================
# INTERNET ROUTING
#==============================================================================

resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_id
  display_name   = "${var.resource_prefix}-igw"
  enabled        = true
  vcn_id         = oci_core_vcn.this.id

  freeform_tags = var.freeform_tags
}

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_id
  display_name   = "${var.resource_prefix}-public-rt"
  vcn_id         = oci_core_vcn.this.id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.this.id
  }

  freeform_tags = var.freeform_tags
}

#==============================================================================
# SERVER SUBNET
#==============================================================================

resource "oci_core_security_list" "subnet" {
  compartment_id = var.compartment_id
  display_name   = "${var.resource_prefix}-subnet-sl"
  vcn_id         = oci_core_vcn.this.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  freeform_tags = var.freeform_tags
}

resource "oci_core_subnet" "servers" {
  cidr_block                 = var.subnet_cidr
  compartment_id             = var.compartment_id
  display_name               = "${var.resource_prefix}-servers-subnet"
  dns_label                  = "servers"
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.public.id
  security_list_ids          = [oci_core_security_list.subnet.id]
  vcn_id                     = oci_core_vcn.this.id

  freeform_tags = var.freeform_tags
}

#==============================================================================
# SERVER NETWORK SECURITY GROUP
#==============================================================================

resource "oci_core_network_security_group" "servers" {
  compartment_id = var.compartment_id
  display_name   = "${var.resource_prefix}-servers-nsg"
  vcn_id         = oci_core_vcn.this.id

  freeform_tags = var.freeform_tags
}

resource "oci_core_network_security_group_security_rule" "server_egress" {
  network_security_group_id = oci_core_network_security_group.servers.id
  direction                 = "EGRESS"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
  protocol                  = "all"
}

resource "oci_core_network_security_group_security_rule" "server_internal" {
  network_security_group_id = oci_core_network_security_group.servers.id
  direction                 = "INGRESS"
  protocol                  = "all"
  source                    = var.vcn_cidr
  source_type               = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "server_ssh" {
  network_security_group_id = oci_core_network_security_group.servers.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.ssh_allowed_cidr
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      max = 22
      min = 22
    }
  }
}

#==============================================================================
# PUBLIC WEB NETWORK SECURITY GROUP
#==============================================================================

resource "oci_core_network_security_group" "public_web" {
  compartment_id = var.compartment_id
  display_name   = "${var.resource_prefix}-public-web-nsg"
  vcn_id         = oci_core_vcn.this.id

  freeform_tags = var.freeform_tags
}

resource "oci_core_network_security_group_security_rule" "public_web" {
  for_each = toset(["80", "443"])

  network_security_group_id = oci_core_network_security_group.public_web.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      max = tonumber(each.value)
      min = tonumber(each.value)
    }
  }
}
