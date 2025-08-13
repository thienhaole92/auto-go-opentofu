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

module "ssh" {
  source = "../../modules/ssh"

  project_name = var.project_name
  environment  = var.environment
  ssh_keys     = var.ssh_keys
}
