include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../..//modules/droplet"
}

dependency "vpc" {
  config_path = "../vpc"

  # Enable mocks for all read-only commands
  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_strategy_with_state  = "shallow"

  # Comprehensive mock outputs that match real resource structure
  mock_outputs = {
    vpc_uuid = "mock-vpc-uuid"
  }
}

inputs = {
  vpc_uuid       = dependency.vpc.outputs.vpc_uuid
  instance_count = 1
  instance_size  = "s-1vcpu-1gb-amd"
  os_image       = "ubuntu-25-04-x64"
  ssh_keys = [
    "77:37:9a:f3:ad:08:54:0a:e7:16:9d:bb:e2:04:45:11"
  ]
}
