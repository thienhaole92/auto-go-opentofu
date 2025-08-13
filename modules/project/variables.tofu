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

variable "purpose" {
  description = "The purpose of the project."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_ ]+$", var.purpose))
    error_message = "Purpose must be alphanumeric and may contain hyphens, underscores, and spaces."
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

variable "resources" {
  description = <<EOT
    A list of Uniform Resource Names (URNs) for DigitalOcean resources to associate with the project.
    URN format: `do:<resource_type>:<resource_id>` (e.g., `"do:droplet:123456"`, `"do:kubernetes:abcde123"`).
    See DigitalOcean's documentation for valid URNs: https://docs.digitalocean.com/reference/doctl/reference/projects/resources/assign/
  EOT

  type     = set(string) # Prevents duplicate entries
  default  = []          # Defaults to empty set
  nullable = false       # Ensures the value is never null

  validation {
    condition = alltrue([
      for urn in var.resources :
      can(regex("^do:[a-z0-9_]+:[a-zA-Z0-9-]+$", urn)) &&
      length(split(":", urn)) == 3
    ])
    error_message = <<-EOT
      Invalid URN format. Each URN must:
      1. Start with 'do:'
      2. Follow the pattern `do:<resource_type>:<resource_id>`
      3. Examples: "do:droplet:123456", "do:kubernetes:cluster-id"
    EOT
  }

  sensitive = false
}
