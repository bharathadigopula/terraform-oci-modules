#==============================================================================
# AMPERE A1 COMPUTE INSTANCES
#==============================================================================

resource "oci_core_instance" "this" {
  for_each = var.instances

  availability_domain  = var.availability_domain
  compartment_id       = var.compartment_id
  display_name         = each.value.display_name
  preserve_boot_volume = false
  shape                = each.value.shape

  dynamic "shape_config" {
    for_each = each.value.shape == "VM.Standard.A1.Flex" ? [each.value] : []

    content {
      memory_in_gbs = shape_config.value.memory_in_gbs
      ocpus         = shape_config.value.ocpus
    }
  }

  create_vnic_details {
    assign_public_ip = each.value.assign_public_ip
    display_name     = "${each.value.display_name}-vnic"
    hostname_label   = each.value.hostname_label
    nsg_ids = concat(
      [var.server_nsg_id],
      each.value.public_web ? [var.public_web_nsg_id] : []
    )
    subnet_id = var.subnet_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  source_details {
    boot_volume_size_in_gbs = each.value.boot_volume_gbs
    source_id               = each.value.image_id
    source_type             = "image"
  }

  freeform_tags = merge(var.freeform_tags, {
    role = each.value.role
  })
}
