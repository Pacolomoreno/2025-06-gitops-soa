locals {
  reconciliation_script = templatefile("${path.module}/reconciliation-script.sh", {
    git_remote   = var.source_repository
    branch       = var.branch
    compose_path = var.compose_path
  })

  cloud_init = templatefile("${path.module}/cloud-init.yaml", {
    boot_delay                     = "2min"
    reconciliation_intervall       = var.reconciliation_interval
    indented_reconciliation_script = indent(6, local.reconciliation_script)
  })
}

resource "hcloud_server" "server" {
  name = "compose-app"

  server_type = var.server_type
  datacenter  = var.datacenter

  image = "debian-12"

  user_data = local.cloud_init

  ssh_keys = var.ssh_key != null ? [var.ssh_key.id] : [] # HCL ternary syntax
}
