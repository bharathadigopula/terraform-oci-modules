#==============================================================================
# ARM IMAGE DISCOVERY
#==============================================================================

data "oci_core_images" "arm" {
  compartment_id           = var.compartment_id
  operating_system         = var.operating_system
  operating_system_version = var.operating_system_version
  shape                    = "VM.Standard.A1.Flex"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

#==============================================================================
# AMPERE A1 COMPUTE INSTANCES
#==============================================================================

resource "oci_core_instance" "this" {
  for_each = var.instances

  availability_domain  = var.availability_domain
  compartment_id       = var.compartment_id
  display_name         = each.value.display_name
  preserve_boot_volume = false
  shape                = "VM.Standard.A1.Flex"

  shape_config {
    memory_in_gbs = each.value.memory_in_gbs
    ocpus         = each.value.ocpus
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
    source_id               = data.oci_core_images.arm.images[0].id
    source_type             = "image"
  }

  freeform_tags = merge(var.freeform_tags, {
    role = each.value.role
  })
}
