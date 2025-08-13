terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.63.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

module "droplet" {
  source = "../../modules/droplet"

  project_name   = var.project_name
  environment    = var.environment
  vpc_uuid       = var.vpc_uuid
  region         = var.region
  instance_count = var.instance_count
  instance_size  = var.instance_size
  os_image       = var.os_image
  ssh_keys       = var.ssh_keys
}
