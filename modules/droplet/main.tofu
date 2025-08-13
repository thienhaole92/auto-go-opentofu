locals {
  resource_prefix = "${var.project_name}-${var.environment}-${var.region}"
}

resource "digitalocean_tag" "instance" {
  name = "${local.resource_prefix}-app"
}

resource "digitalocean_droplet" "app" {
  count       = var.instance_count
  name        = "${local.resource_prefix}-${count.index + 1}"
  region      = var.region
  size        = var.instance_size
  image       = var.os_image
  ssh_keys    = var.ssh_keys
  tags        = [digitalocean_tag.instance.id]
  vpc_uuid    = var.vpc_uuid != "" ? var.vpc_uuid : null
  backups     = false
  monitoring  = true
  ipv6        = true
  resize_disk = true

  lifecycle {
    ignore_changes = [image] # Prevent forced rebuilds on image updates
  }
}
