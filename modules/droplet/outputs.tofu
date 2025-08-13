output "instances" {
  description = "Deployed droplet information"
  value = {
    for idx, droplet in digitalocean_droplet.app : idx => {
      id         = droplet.id
      name       = droplet.name
      ipv4       = droplet.ipv4_address
      ipv6       = droplet.ipv6_address
      region     = droplet.region
      size       = droplet.size
      vpc_uuid   = droplet.vpc_uuid
      tags       = droplet.tags
      created_at = timestamp()
    }
  }
  sensitive = false
}

output "instance_tag_id" {
  description = "The unique identifier of the instance tag"
  value       = digitalocean_tag.instance.id
  sensitive   = false
}
