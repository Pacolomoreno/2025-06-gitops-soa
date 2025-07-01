variable "server_type" {
  description = "The architecture and size of the server. See Hetzner server type lists for valid values."
  type        = string
}

variable "datacenter" {
  description = "The datacenter to use. See Hetzners location for valid values."
  type        = string
}

variable "source_repository" {
  description = "Git repository to use as source for application."
  type        = string
}

variable "branch" {
  description = "The branch to target."
  type        = string
}

variable "compose_path" {
  description = "Path to the compose file."
  type        = string
}

variable "reconciliation_interval" {
  description = "Interval between reconciliation attempts."
  type        = string
}

variable "ssh_key" {
  description = "Optional SSH key reference on Hetzner. You need to upload this yourself."
  default     = null
}
