#==============================================================================
# OCI CORE NETWORK SECURITY GROUP SECURITY RULE
#==============================================================================

resource "oci_core_network_security_group_security_rule" "this" {
  network_security_group_id = var.network_security_group_id
  direction                 = var.direction
  protocol                  = var.protocol
  source                    = var.traffic_source
  source_type               = var.source_type
  stateless                 = var.stateless

  dynamic "tcp_options" {
    for_each = var.tcp_destination_port == null ? [] : [var.tcp_destination_port]

    content {
      destination_port_range {
        max = tcp_options.value
        min = tcp_options.value
      }
    }
  }
}