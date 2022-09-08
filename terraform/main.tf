# Client VMs for testing NAT connections and firewall 
# add '#' on line below to enable
#/*
module "vm-clients" {
  source = "./vm-simple"
  for_each = {
    "Fedora Desktop" = "/var/lib/libvirt/images/Fedora-Workstation-Live-x86_64-36-1.5.iso"
    "Ubuntu Desktop" = "/var/lib/libvirt/images/ubuntu-22.04.1-desktop-amd64.iso"
  }
  name       = each.key
  file       = each.value
  network_id = libvirt_network.router_lab_internal.id
} #*/


resource "libvirt_volume" "alpine_storage" {
  name = "alpine-storage.qcow2"
  size = "10737418240" # 10G in bytes dmacvicar/libvirt#3287
}


resource "libvirt_domain" "alpine_router" {
  name        = "Alpine Router"
  description = "version 3.16.2"
  cpu {
    mode = "host-passthrough"
  }
  vcpu     = "1"
  memory   = "512"
  firmware = "/usr/share/edk2/ovmf/OVMF_CODE.fd"

  boot_device {
    dev = ["hd", "cdrom"]
  }

  disk { # iso
    file = "/var/lib/libvirt/images/alpine-virt-3.16.2-x86_64.iso"
  }
  disk { # qcow2
    volume_id = libvirt_volume.alpine_storage.id
  }

  network_interface {
    network_name = "default"
  }

  network_interface {
    network_id = libvirt_network.router_lab_internal.id
  }
}
