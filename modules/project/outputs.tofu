output "id" {
  description = "The DigitalOcean project ID for infrastructure management"
  value       = digitalocean_project.default.id
  sensitive   = false
}
