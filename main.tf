#######################################
################ PROVIDERS ############

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

#######################################
################ MAIN #################

resource "libvirt_pool" "pool" {
  name = var.vm_hostname
  type = "dir"

  target {
    path = "${var.libvirt_disk_path}/${var.vm_hostname}"
  }
}

resource "libvirt_volume" "ubuntu-qcow2" {
  name   = "${var.vm_hostname}-qcow2"
  pool   = libvirt_pool.pool.name
  source = var.ubuntu_24_img_url
  format = "qcow2"
}

data "template_file" "user_data" {
  template = file("${path.module}/config/cloud_init.yml")
}

data "template_file" "network_config" {
  template = file("${path.module}/config/network_config.yml")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "${var.vm_hostname}-commoninit.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.pool.name
}

resource "libvirt_domain" "domain-ubuntu" {
  name   = var.vm_hostname
  memory = var.vm_memory
  vcpu   = var.vm_vcpu

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    bridge          = "br0"
    wait_for_lease  = false
    hostname        = var.vm_hostname
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.ubuntu-qcow2.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
