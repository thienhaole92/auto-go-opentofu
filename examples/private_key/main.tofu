terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}

module "private_key" {
  source = "../../modules/private_key"
}
