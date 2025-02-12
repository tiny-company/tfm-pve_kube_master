
# ------------------------------------------------------------------
# - Filename: main.tf
# - Author : draed
# - Dependency : none
# - Description : terraform module that create a kubernetes master
# - Creation date : 2025-02-11
# - terraform version : OpenTofu v1.9.0
# ------------------------------------------------------------------

## generate random root password
resource "random_password" "container_root_password" {
  length           = 24
  override_special = "_%@"
  special          = true
  ## prevent regenerate each time the job is running (only first time)
  lifecycle {
    ignore_changes = all
  }
}

## generate random mac address
resource "macaddress" "kube_master_net_int_mac_addr" {
  ## prevent regenerate each time the job is running (only first time)
  lifecycle {
    ignore_changes = all
  }
}

## create kubernetes master 
resource "proxmox_virtual_environment_container" "test_vigea_kube_master-test" {
  count = 1
  description   = var.kube_master_description
  node_name     = var.terraform_proxmox_node_name
  start_on_boot = true
  unprivileged  = true
  vm_id         = var.terraform_proxmox_lxc_highest_id_value + 1 + count.index

  cpu {
    architecture = var.kube_master_cpu_arch
    cores        = var.kube_master_cpu_cores
  }

  disk {
    datastore_id = var.kube_master_disk_datastore
    size         = var.kube_master_disk_size
  }

  memory {
    dedicated = var.kube_master_mem_dedi
    swap      = var.kube_master_mem_swap
  }

  operating_system {
    template_file_id = var.kube_master_os_templ_file
    type             = var.kube_master_os_type
  }

  initialization {
    hostname = "${var.kube_master_hostname}-${tostring(count.index + 1)}" ## add 1 cause 'count' start to 0 
    

    ip_config {
      ipv4 {
        address = "${cidrhost("${var.kube_master_ipv4_gw}${var.kube_master_ipv4_mask}", var.kube_master_ipv4_start_addr + count.index)}${var.kube_master_ipv4_mask}"
        gateway = var.kube_master_ipv4_gw
      }
    }
    user_account {
      keys     = var.kube_master_ssh_pub_keys
      password = random_password.container_root_password.result
    }
  }
  network_interface {
    name        = var.kube_master_net_int_name
    mac_address = macaddress.kube_master_net_int_mac_addr.address
  }

  features {
    nesting = true
    fuse    = false
  }

#   ## ignore change in network configuration
#   lifecycle {
#     ignore_changes = [
#       network_interface
#     ]
#   }

}