output "vpc_uuid" {
  description = "The ID of the primary VPC for direct reference in other configurations"
  value       = digitalocean_vpc.default.id
  depends_on  = [digitalocean_vpc.default]
}
