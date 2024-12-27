terraform {
  required_version = ">= 0.15"
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu+ssh://ursula@node01/system"
}
