output "kube_master_ipv4_addr" {
  description = "kube master ipv4 address"
  value = proxmox_virtual_environment_container.test_vigea_kube_master-test[*].initialization[0].ip_config[0].ipv4[0].address
  sensitive = true
}

output "kube_master_highest_vmid" {
  description = "kube master highest vm id"
  value = max(proxmox_virtual_environment_container.test_vigea_kube_master-test[*].vm_id...)
}