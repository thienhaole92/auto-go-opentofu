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