output "droplets" {
  description = "Deployed droplet information"
  value = {
    for idx, droplet in digitalocean_droplet.app : idx => {
      id       = droplet.id
      name     = droplet.name
      ipv4     = droplet.ipv4_address
      ipv6     = droplet.ipv6_address
      region   = droplet.region
      size     = droplet.size
      vpc_uuid = droplet.vpc_uuid
      tags     = droplet.tags
    }
  }
  sensitive = false
}

output "urns" {
  description = <<EOT
  List of Uniform Resource Names (URNs) for all deployed droplets.
  URN format: do:droplet:<ID>
  Useful for resource tracking and API operations across DigitalOcean's platform.
  EOT
  value       = digitalocean_droplet.app[*].urn
}

output "tag_id" {
  description = "The unique identifier of the instance tag"
  value       = digitalocean_tag.instance.id
  sensitive   = false
}
