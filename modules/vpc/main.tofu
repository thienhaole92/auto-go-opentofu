locals {
  resource_prefix = "${var.project_name}-${var.environment}"
}

resource "digitalocean_vpc" "default" {
  name     = "${local.resource_prefix}-${var.region}"
  region   = var.region
  ip_range = var.cidr_block
}
