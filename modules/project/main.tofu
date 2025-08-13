locals {
  resource_prefix = "${var.project_name}-${var.environment}"
}

resource "digitalocean_project" "default" {
  name        = "${local.resource_prefix}-project"
  description = "Golang test application for automated deployment via GitHub Actions."
  purpose     = var.purpose
  environment = var.environment
}

# The following resource types can be associated with a project:
# - Database Clusters
# - Domains
# - Droplets
# - Floating IP
# - Load Balancers
# - Spaces Bucket
# - Volume

resource "digitalocean_project_resources" "default" {
  project   = digitalocean_project.default.id
  resources = var.resources
}
