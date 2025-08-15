locals {
  resource_prefix = "${var.project_name}-${var.environment}"
  any_ipv4        = ["0.0.0.0/0"]
  any_ipv6        = ["::/0"]
  any_ip          = concat(local.any_ipv4, local.any_ipv6)
}

resource "digitalocean_firewall" "ssh" {
  name = "${local.resource_prefix}-ssh-access"
  tags = var.tags

  # SSH Outbound (required for git operations, etc)
  outbound_rule {
    protocol              = "tcp"
    port_range            = "22"
    destination_addresses = var.ssh_allowed
  }

  # SSH Inbound (only enable for non-production or with strict IPs)
  dynamic "inbound_rule" {
    for_each = length(var.ssh_allowed) > 0 ? [1] : []
    content {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = var.ssh_allowed
    }
  }
}

# Web/DNS/NTP firewall (standard internet-facing services)
resource "digitalocean_firewall" "web" {
  name = "${local.resource_prefix}-web-services"
  tags = var.tags

  # HTTP/HTTPS
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = local.any_ip
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = local.any_ip
  }

  # Outbound internet access
  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = local.any_ip
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = local.any_ip
  }

  # DNS (TCP + UDP)
  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = local.any_ip
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = local.any_ip
  }

  # NTP
  outbound_rule {
    protocol              = "udp"
    port_range            = "123"
    destination_addresses = local.any_ip
  }
}

resource "digitalocean_firewall" "application_firewall" {
  count = length(var.allowed_tcp_ports) > 0 ? 1 : 0
  
  name = var.allowed_tcp_ports != [] ? format(
    "%s-fw-%s",
    local.resource_prefix,
    join("-", compact([
      for port in sort(var.allowed_tcp_ports) :
      lookup({
        3306 = "mysql",
        5432 = "postgres"
      }, port, "port${port}")
    ]))
  ) : "${local.resource_prefix}-fw-default"

  tags = var.tags

  # Dynamic inbound rules for all specified ports
  dynamic "inbound_rule" {
    for_each = toset(var.allowed_tcp_ports) # Using toset to avoid duplicates
    content {
      protocol         = "tcp"
      port_range       = inbound_rule.key
      source_addresses = local.any_ip
    }
  }
}
