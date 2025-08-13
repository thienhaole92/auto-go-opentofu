locals {
  resource_prefix = "${var.project_name}-${var.environment}"
}

resource "digitalocean_project" "default" {
  name        = "${local.resource_prefix}-project"
  description = "Golang test application for automated deployment via GitHub Actions."
  purpose     = var.purpose
  environment = var.environment
}
