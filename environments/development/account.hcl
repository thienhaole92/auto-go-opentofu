locals {
  access_key            = get_env("SPACES_ACCESS_KEY")
  secret_key            = get_env("SPACES_SECRET_KEY")
  state_bucket_name     = get_env("TF_STATE_BUCKET_NAME")
  state_bucket_endpoint = get_env("TF_STATE_BUCKET_ENDPOINT")
  do_token              = get_env("DIGITALOCEAN_TOKEN")
}
