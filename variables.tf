variable "libvirt_disk_path" {
  description = "Path for libvirt pool"
  default     = "/opt/kvm"
}

variable "ubuntu_24_img_url" {
  description = "Ubuntu 24.04 image URL"
  default     = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img"
}

variable "vm_hostname" {
  description = "Hostname for the VM"
}

variable "vm_memory" {
  description = "Memory for the VM in MB"
  default     = 512
}

variable "vm_vcpu" {
  description = "Number of virtual CPUs for the VM"
  default     = 1
}

