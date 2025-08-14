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

variable "instance_count" {
  description = "Number of droplets to deploy"
  type        = number
  default     = 1
  validation {
    condition     = var.instance_count >= 0 && var.instance_count <= 10
    error_message = "Instance count must be between 0 and 10"
  }
}

variable "vpc_uuid" {
  description = "UUID of the VPC where droplets will be deployed"
  type        = string
}

variable "instance_size" {
  description = "Droplet size slug"
  type        = string
  default     = "s-1vcpu-1gb-amd"
  validation {
    condition     = can(regex("^[sdc]-[0-9]vcpu-[0-9]gb-(amd|intel|arm)$", var.instance_size))
    error_message = "Invalid droplet size format. Must match pattern: [sdc]-Xvcpu-Ygb-[amd|intel|arm]"
  }
}

variable "os_image" {
  description = "Operating system image slug"
  type        = string
  default     = "ubuntu-25-04-x64"
  validation {
    condition     = can(regex("^(ubuntu|debian|centos|rocky|fedora)-[0-9]{2}-[0-9]{2}-x64$", var.os_image))
    error_message = "Invalid OS image format. Must be like: ubuntu-22-04-x64"
  }
}

variable "ssh_keys" {
  description = "A list of SSH key IDs or fingerprints for access"
  type        = list(string)
  default     = []
  validation {
    condition = alltrue([
      for key in var.ssh_keys : can(regex("^[0-9a-f]{2}(:[0-9a-f]{2}){15}$", key))
    ])
    error_message = "SSH fingerprints must be in colon-separated hex format (e.g. ab:cd:ef:...)"
  }
}
