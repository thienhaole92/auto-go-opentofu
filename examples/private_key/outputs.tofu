output "private_key_pem" {
  value     = module.private_key.private_key_pem
  sensitive = true
}

output "public_key_openssh" {
  value = module.private_key.public_key_openssh
}

output "key_fingerprint" {
  value = module.private_key.key_fingerprint
}
