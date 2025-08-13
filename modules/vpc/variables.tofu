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

variable "region" {
  description = <<EOT
  The DigitalOcean region slug where resources will be deployed.
  Examples: 'nyc1', 'sfo2', 'sgp1', 'lon1'
  Reference: https://docs.digitalocean.com/products/platform/availability-matrix/
  EOT

  type    = string
  default = "nyc3"

  validation {
    condition = contains([
      "nyc1", "nyc3", "sfo2", "sfo3", "ams2", "ams3",
      "sgp1", "lon1", "fra1", "tor1", "blr1", "syd1"
    ], var.region)
    error_message = <<EOT
    Invalid DigitalOcean region specified. Must be one of:
    nyc1, nyc3, sfo2, sfo3, ams2, ams3, sgp1, lon1, fra1, tor1, blr1, syd1
    EOT
  }
}

variable "cidr_block" {
  description = <<EOT
  The CIDR block for the VPC network.
  Must be a private IP range (RFC 1918) in CIDR notation.
  Recommended ranges:
  - 10.0.0.0/8 (large deployments)
  - 172.16.0.0/12 (medium deployments)
  - 192.168.0.0/16 (small deployments)
  EOT

  type    = string
  default = "172.31.0.0/16"

  validation {
    condition = can(cidrnetmask(var.cidr_block)) && (
      cidrhost(var.cidr_block, 0) != null &&
      can(regex("^(10\\.|172\\.(1[6-9]|2[0-9]|3[0-1])\\.|192\\.168\\.)", var.cidr_block)) &&
      parseint(split("/", var.cidr_block)[1], 10) >= 16 &&
      parseint(split("/", var.cidr_block)[1], 10) <= 24
    )
    error_message = <<EOT
    Invalid VPC CIDR block. Must be:
    - RFC 1918 private range (10.x.x.x, 172.16-31.x.x, 192.168.x.x)
    - CIDR notation with /16 to /24 netmask
    - Example: 10.0.0.0/16, 172.31.0.0/16
    EOT
  }
}
