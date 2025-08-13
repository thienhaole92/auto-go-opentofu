variable "ssh_keys" {
  description = <<EOT
  List of SSH public keys to be added to DigitalOcean account.
  Each key should be an object with:
  - name: Unique identifier (alphanumeric + hyphens/underscores)
  - public_key: Valid SSH public key string (rsa/ed25519/ecdsa)
  EOT

  type = list(object({
    name       = string
    public_key = string
  }))

  default = []

  validation {
    condition = alltrue([
      for key in var.ssh_keys :
      can(regex("^[a-zA-Z0-9_-]{1,64}$", key.name))
    ])
    error_message = "Key names must be 1-64 alphanumeric chars with hyphens/underscores."
  }

  validation {
    condition     = length(distinct([for key in var.ssh_keys : key.name])) == length(var.ssh_keys)
    error_message = "All SSH key names must be unique."
  }
}

variable "project_name" {
  description = <<EOT
  The name of the project this infrastructure belongs to.
  Should follow organizational naming conventions.
  Examples: 'ecommerce-platform', 'customer-portal', 'data-pipeline-2023'
  EOT
  type        = string
  nullable    = false

  validation {
    condition = (
      length(var.project_name) >= 3 &&
      length(var.project_name) <= 64 &&
      can(regex("^[a-z0-9-]+$", var.project_name))
    )
    error_message = <<EOT
    Project name must be 3-64 characters, lowercase alphanumeric with hyphens.
    No spaces or special characters allowed.
    EOT
  }
}

variable "environment" {
  description = "The deployment environment (e.g., development, staging, production])."
  type        = string
  nullable    = false
  default     = "dev"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of: development, staging, production."
  }
}
