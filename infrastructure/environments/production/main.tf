variable "debug_key" {
  description = "Public SSH key for debugging. Optional."
  type        = string
  default     = null
}

module "gitops_lite" {
  source = ""

  # Hardware configuration
  server_type = "cpx31"    # x86, 4 vCPU, 8GB
  location    = "hel1-dc2" # Helsinki

  # Application configuration
  source_repository       = "https://github.com/LarsGJobloop/2025-06-gitops-soa.git"
  branch                  = "main"
  reconciliation_interval = "1min"

  # DEVELOPMENT ONLY
  ssh_key = var.debug_key
}
