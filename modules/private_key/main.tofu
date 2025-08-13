resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096

  lifecycle {
    prevent_destroy = true # Prevent accidental deletion of active keys
  }
}
