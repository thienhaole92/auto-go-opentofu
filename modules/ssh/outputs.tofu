output "ssh_key_ids" {
  description = "Map of SSH key names to their DigitalOcean IDs"
  value = {
    for key_name, key in digitalocean_ssh_key.default : key_name => key.id
  }
}
