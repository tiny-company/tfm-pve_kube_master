## promox vars

variable "terraform_proxmox_node_name" {
  type      = string
  sensitive = true
}

variable "terraform_proxmox_lxc_highest_id_value" {
  type      = number
  sensitive = true
}

## kube master variables

variable "kube_master_description" {
  type      = string
  default   = "Kubernetes master"
}

variable "kube_master_cpu_arch" {
  type      = string
  default   = "amd64"
}

variable "kube_master_cpu_cores" {
  type      = number
  default   = 2
}

variable "kube_master_disk_datastore" {
  type      = string
  sensitive = true
}

variable "kube_master_disk_size" {
  type      = number
  default   = 10
}

variable "kube_master_mem_dedi" {
  type      = number
  default   = 1024
}

variable "kube_master_mem_swap" {
  type      = number
  default   = 0
}

variable "kube_master_os_templ_file" {
  type      = string
  sensitive = true
}

variable "kube_master_os_type" {
  type      = string
  default   = "debian"
}

variable "kube_master_hostname" {
  type      = string
  sensitive = true
}

variable "kube_master_ipv4_start_addr" {
  type      = number
  sensitive = true
}

variable "kube_master_ipv4_mask" {
  type      = string
  default   = "/24"
}

variable "kube_master_ipv4_gw" {
  type      = string
  sensitive = true
}

variable "kube_master_ssh_pub_keys" {
  type      = list(string)
  sensitive = true
}

variable "kube_master_net_int_name" {
  type      = string
  sensitive = true
}

variable "kube_master_net_bridge_int_name" {
  type      = string
  sensitive = true
}

variable "kube_master_default_username" {
  type      = string
  default   = "root"
}
