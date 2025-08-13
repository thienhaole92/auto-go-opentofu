include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../..//modules/vpc"
}

inputs = {
  cidr_block = "192.168.0.0/16"
}
