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

module "project" {
  source = "../../modules/project"

  project_name = var.project_name
  purpose      = var.purpose
  environment  = var.environment
}
