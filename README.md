# Virtual Machine Template Deployment

Terraform template for deploying virtual machines on Libvirt.

## Overview

This template automates the deployment of an Ubuntu 24.04 cloud image on KVM. It creates a storage pool under `/opt/kvm/$hostname` and configures a fixed IP address for the network.

## Prerequisites

### Dependencies

- A stable internet connection to download the Ubuntu image from cloud-images.
- Export your SSH public key for accessing the node (`node01`).

### Installation

- Clone this repository to `/opt/node01-vms/`.

### Running the Template

1. Modify the `terraform.tfvars` file to set the desired hostname, memory, and vCPU settings.
2. Update the IP address in the `config/network_config.yml` file.
3. Set the root password in the `config/cloud_init.yml` file.



