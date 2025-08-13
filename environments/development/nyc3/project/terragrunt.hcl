include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../..//modules/project"
}

inputs = {
  project_name = "auto-go"
  purpose      = "Golang CI-CD Pipeline Testing"
  environment  = "development"
  resources    = []
}

