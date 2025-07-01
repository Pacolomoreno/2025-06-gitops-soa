terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.50.0"
    }
  }
}

provider "hcloud" {
  token = var.hetzner_token
}

variable "hetzner_token" {
  description = "Hetzner API token"
  type        = string
  sensitive   = true
}
