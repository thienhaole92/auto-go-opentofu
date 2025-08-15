include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../..//modules/networking"
}

dependency "droplet" {
  config_path = "../droplet"

  # Enable mocks for all read-only commands
  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_strategy_with_state  = "shallow"

  # Comprehensive mock outputs that match real resource structure
  mock_outputs = {
    droplets = [
      {
        id           = "mock-droplet-123"
        name         = "mock-droplet"
        ipv4_address = "10.0.0.1"
      }
    ]
    tag_id = "mock-tag-123"
    urns   = ["do:droplet:mock123"]
  }
}

inputs = {
  ssh_allowed          = ["0.0.0.0/0", "::/0"]
  tags                 = [dependency.droplet.outputs.tag_id],
  application_firewall = [9080]
}
