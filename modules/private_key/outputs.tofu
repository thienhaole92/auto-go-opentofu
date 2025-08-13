output "private_key_pem" {
  description = <<EOT
  [SECURE] RSA Private Key in PEM format.
  ⚠️ Handle with extreme care in CI/CD:
  1. Immediately store in secret manager
  2. Never log or persist in artifacts
  3. Restrict to necessary jobs only
  EOT
  sensitive   = true
  value       = tls_private_key.default.private_key_pem
}

output "public_key_openssh" {
  description = "Public key for authorized_keys"
  value       = tls_private_key.default.public_key_openssh
}

output "key_fingerprint" {
  description = "SHA256 fingerprint for key verification"
  value       = tls_private_key.default.public_key_fingerprint_sha256
}