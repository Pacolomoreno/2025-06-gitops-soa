variable "debug_key" {
  description = "Public SSH key for debugging. Optional."
  type        = string
  default     = null
}

resource "hcloud_ssh_key" "debug_key" {
  count      = var.debug_key != null ? 1 : 0 # HCL Conditional syntax. Hacky, but works
  name       = "compose-app-ssh-key"
  public_key = var.debug_key
}

module "gitops_lite" {
  source = "../../modules/compose-app-hetzner"

  # Hardware configuration
  server_type = "cpx31"    # Hetzner Machine type -> arch=x86, cores=4vCPU, ram=8GB, hdd=160GB
  datacenter  = "hel1-dc2" # Helsinki

  # Application configuration
  source_repository       = "https://github.com/LarsGJobloop/2025-06-gitops-soa.git"
  branch                  = "main"
  compose_path            = "compose.production.yaml"
  reconciliation_interval = "1min"

  # DEVELOPMENT ONLY
  ssh_key = var.debug_key != null ? hcloud_ssh_key.debug_key[0] : null
}

output "compose_app" {
  value = module.gitops_lite.info
}
output "cloud-init" {
  value = module.gitops_lite.cloud_init
}
output "reconciliation-script" {
  value = module.gitops_lite.reconciliation_script
}
