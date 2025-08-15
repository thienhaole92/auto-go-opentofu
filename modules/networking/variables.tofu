variable "tags" {
  description = "List of Droplet tags identifying allowed sources for inbound traffic"
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for tag in var.tags : can(regex("^[a-z0-9-]{1,255}$", tag))
    ])
    error_message = "Tags must be 1-255 chars, lowercase alphanumeric with hyphens"
  }
}

variable "ssh_allowed" {
  description = "Network ranges explicitly allowed for SSH connections"
  type        = list(string)
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

variable "allowed_tcp_ports" {
  description = "List of TCP ports to allow through the firewall"
  type        = list(number)
  default     = []
  validation {
    condition = alltrue([
      for port in var.allowed_tcp_ports : port > 0 && port <= 65535
    ])
    error_message = "Ports must be between 1 and 65535."
  }
}
