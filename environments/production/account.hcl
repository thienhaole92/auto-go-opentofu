locals {
  access_key      = get_env("SPACES_ACCESS_KEY")
  secret_key      = get_env("SPACES_SECRET_KEY")
  bucket          = get_env("SPACES_BUCKET_NAME")
  bucket_endpoint = get_env("SPACES_BUCKET_ENDPOINT")
  do_token        = get_env("DO_TOKEN")
}
