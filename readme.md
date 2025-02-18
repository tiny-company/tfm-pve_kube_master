# tfm-pve_kube_master

## Description

A simple terraform module that create a kubernetes master instance in proxmox provider.

## prerequisite

- This module has dependency to the [tfm-pve_highest_lxc_id](https://github.com/tiny-company/tfm-pve_highest_lxc_id), it's installation and configuration is included in the [usage](#usage) section below.

## Usage 

- Import the module by referencing it in your main terraform file (`main.tf`) using :
```hcl
module "pve_highest_lxc_id" {
  source     = "git::https://github.com/tiny-company/tfm-pve_highest_lxc_id.git"
  proxmox_api_host = var.proxmox_api_host
  proxmox_api_nodename = var.terraform_proxmox_node_name
  proxmox_api_username = var.proxmox_api_username
  proxmox_api_tokenname = var.proxmox_api_tokenname
  proxmox_api_tokenvalue = var.proxmox_api_tokenvalue
}

module "proxmox-kub_master" {
  source = "git::https://github.com/tiny-company/tfm-pve_kube_master"
  kube_master_description = var.kube_master_description
  terraform_proxmox_node_name = var.terraform_proxmox_node_name
  terraform_proxmox_lxc_highest_id_value = module.proxmox-highest_lxc_id.lxc_highest_id_value
  kube_master_cpu_arch = var.kube_master_cpu_arch
  kube_master_cpu_cores = var.kube_master_cpu_cores
  kube_master_disk_datastore = var.kube_master_disk_datastore
  kube_master_disk_size = var.kube_master_disk_size
  kube_master_mem_dedi = var.kube_master_mem_dedi
  kube_master_mem_swap = var.kube_master_mem_swap
  kube_master_os_templ_file = var.kube_master_os_templ_file
  kube_master_os_type = var.kube_master_os_type
  kube_master_hostname = var.kube_master_hostname
  kube_master_ipv4_start_addr = var.kube_master_ipv4_start_addr
  kube_master_ipv4_mask = var.kube_master_ipv4_mask
  kube_master_ipv4_gw = var.kube_master_ipv4_gw
  kube_master_ssh_pub_keys = var.default_root_ssh_pub_keys
  kube_master_net_int_name = var.kube_master_net_int_name
  kube_master_net_bridge_int_name = var.kube_master_net_bridge_int_name
}
```

- Don't forget to define the vars below in your main variables.tf :
```hcl
## vars for pve_highest_lxc_id module

variable "python_version" {
  type      = string
  default   = "3.11.2"
}

variable "proxmox_api_host" {
  type      = string
  sensitive = true
}

variable "proxmox_api_nodename" {
  type      = string
  sensitive = true
}

variable "proxmox_api_username" {
  type      = string
  sensitive = true
}

variable "proxmox_api_tokenname" {
  type      = string
  sensitive = true
}

variable "proxmox_api_tokenvalue" {
  type      = string
  sensitive = true
}

## vars for proxmox-kub_master module

variable "terraform_proxmox_node_name" {
  type      = string
  sensitive = true
}

variable "terraform_proxmox_lxc_highest_id_value" {
  type      = number
  sensitive = true
}

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
  default   = 256
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
```

- And finally don't forget to set **these vars** and **the vars for the proxmox/bpg provider** in a .tfvars (i.e: `terraform.tfvars`) file  :
```hcl
pve_endpoint="https://proxmox_endpoint_url/"
pve_token="proxmox_username@authentication_base!token_name=0000000-00000-00000-000000-4532433"
proxmox_api_host="proxmox_endpoint"
proxmox_api_tokenname="token_name"
proxmox_api_tokenvalue="0000000-00000-00000-000000-4532433"
proxmox_api_username="proxmox_username@authentication_base"
terraform_proxmox_node_name="proxmox_node"
terraform_proxmox_templ_loc="proxmox_template_location"
kube_master_description="kube master for testing kubernetes"
kube_master_cpu_arch="amd64"
kube_master_cpu_cores=2
kube_master_disk_datastore="local-lvm"
kube_master_disk_size=10
kube_master_mem_dedi=1024
kube_master_mem_swap=256
kube_master_os_templ_file="local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
kube_master_os_type="debian"
kube_master_hostname="test-kube-master-test"
kube_master_ipv4_start_addr=50
kube_master_ipv4_mask="/24"
kube_master_ipv4_gw="192.168.1.1"
default_root_ssh_pub_keys=["ssh-rsa public_key_to_be_installed_on_the_kube_instances"]
kube_master_net_int_name="eth0"
kube_master_net_bridge_int_name="vmbr1"
```

## Sources : 

- [tutorial terraform module](https://developer.hashicorp.com/terraform/tutorials/modules/module)
- [terraform module creation guide](https://developer.hashicorp.com/terraform/language/modules/develop)
- [terraform module source](https://developer.hashicorp.com/terraform/language/modules/sources#github)
- [terraform module git private repo source](https://medium.com/@dipandergoyal/terraform-using-private-git-repo-as-module-source-d20d8cec7c5)