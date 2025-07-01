variable "debug_key" {
  description = "Public SSH key for debugging. Optional."
  type        = string
  default     = null
}

resource "hcloud_ssh_key" "debug_key" {
  name = "compose-app-ssh-key"
  # Associated Id stored in /secrets/debug_key
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaB/mzskgoQF0xcRY79l9FbIzVwK7Vqgowaxk5klJf8"
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
  ssh_key = hcloud_ssh_key.debug_key
}

output "compose_app" {
  value = module.gitops_lite.info
}
