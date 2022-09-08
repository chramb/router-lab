resource "libvirt_domain" "basic_vm" {
  name        = var.name
  description = var.description
  cpu {
    mode = "host-passthrough"
  }
  vcpu   = "1"
  memory = "2048"

  disk {
    file = var.file
    scsi = "true"
  }

  network_interface {
    network_id     = var.network_id
    wait_for_lease = false
  }
}
