locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract the variables we need for easy access
  environment           = local.environment_vars.locals.environment
  project_name          = local.environment_vars.locals.project_name
  access_key            = local.account_vars.locals.access_key
  secret_key            = local.account_vars.locals.secret_key
  state_bucket_name     = local.account_vars.locals.state_bucket_name
  state_bucket_endpoint = local.account_vars.locals.state_bucket_endpoint
  do_token              = local.account_vars.locals.do_token
  region                = local.region_vars.locals.region
  aws_region            = local.region_vars.locals.aws_region
}

inputs = {
  environment  = "${local.environment}"
  project_name = "${local.project_name}"
  region       = "${local.region}"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "digitalocean" {
  token = "${local.do_token}"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    access_key                  = "${local.access_key}"
    secret_key                  = "${local.secret_key}"
    endpoint                    = "${local.state_bucket_endpoint}"
    bucket                      = "${local.state_bucket_name}"
    region                      = "${local.aws_region}"
    key                         = "${local.project_name}/${path_relative_to_include()}/terraform.tfstate"
  }
}
EOF
}
