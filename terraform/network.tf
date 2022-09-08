resource "libvirt_network" "router_lab_internal" {
  name      = "router-lab-internal"
  mode      = "none"
  domain    = "router-lab-internal"
  addresses = ["10.31.0.0/24"]
  dhcp {
    enabled = false
  }
}
