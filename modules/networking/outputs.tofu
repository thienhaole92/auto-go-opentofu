output "firewall_status" {
  description = <<EOT
  Current status of deployed firewalls including:
  - SSH access firewall configuration
  - Web services firewall rules
  - Associated resources and creation metadata
  EOT

  value = {
    ssh_firewall = {
      name = digitalocean_firewall.ssh.name
      inbound_rules = [for rule in digitalocean_firewall.ssh.inbound_rule : {
        protocol = rule.protocol
        ports    = rule.port_range
        sources  = rule.source_addresses
      }]
      protected_tags = digitalocean_firewall.ssh.tags
    }

    web_firewall = {
      name = digitalocean_firewall.web.name
      http_rules = [for rule in digitalocean_firewall.web.inbound_rule : {
        protocol = rule.protocol
        ports    = rule.port_range
        sources  = rule.source_addresses
      } if contains(["80", "443"], rule.port_range)]
      dns_ntp_rules = [for rule in digitalocean_firewall.web.outbound_rule : {
        protocol     = rule.protocol
        ports        = rule.port_range
        destinations = rule.destination_addresses
      } if contains(["53", "123"], rule.port_range)]
    }

    metadata = {
      deployed_at  = timestamp()
      tf_workspace = terraform.workspace
      environment  = var.environment
    }
  }

  sensitive = false
}