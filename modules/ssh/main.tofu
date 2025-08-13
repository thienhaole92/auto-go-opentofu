locals {
  resource_prefix = "${var.project_name}-${var.environment}"
}

resource "digitalocean_ssh_key" "default" {
  for_each = { for key in var.ssh_keys : key.name => key }

  name       = "${local.resource_prefix}-${each.value.name}"
  public_key = each.value.public_key
}
