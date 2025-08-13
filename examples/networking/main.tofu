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

module "networking" {
  source = "../../modules/networking"

  project_name = var.project_name
  environment  = var.environment
  ssh_allowed  = var.ssh_allowed
  tags         = var.tags
}
