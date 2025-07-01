output "info" {
  description = "Compose application description"
  value       = hcloud_server.server
}

output "cloud_init" {
  value = local.cloud_init
}

output "reconciliation_script" {
  value = local.reconciliation_script
}
