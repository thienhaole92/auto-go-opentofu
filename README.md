# auto-go-opentofu

**auto-go-opentofu** is a collection of Infrastructure-as-Code (IaC) configurations designed to automate the provisioning and management of infrastructure on **DigitalOcean** using [OpenTofu](https://opentofu.org/) and Terragrunt.

## 🛠️ Prerequisites

### Core Tools

To use this repository, you'll want to make sure you have the following installed:

| Tool                                                                        | Installation              | Verified Version |
| --------------------------------------------------------------------------- | ------------------------- | ---------------- |
| [OpenTofu](https://opentofu.org/docs/intro/install/)                        | `mise install tofu`       | `1.6.0`          |
| [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) | `mise install terragrunt` | `0.54.0`         |
| [Go](https://go.dev/doc/install)                                            | `mise install go`         | `1.24.6`         |

To simplify the process of installing these tools, you can install [mise](https://mise.jdx.dev/), then run the following to concurrently install all the tools you need, pinned to the versions they were tested with (as tracked in the [mise.toml](./mise.toml) file):

```bash
# Install all tools with version pinning (via mise)
mise install
```

### Environment Configuration

Create a `.env` file with:

```bash
# DigitalOcean Credentials
export DIGITALOCEAN_TOKEN="dop_v1_..."  # Least-privilege token
export SPACES_ACCESS_KEY="..."          # R/W only for state bucket
export SPACES_SECRET_KEY="..."          # Encrypt with GPG

# State Configuration
export TF_STATE_BUCKET="org-tfstate-${ENV}"
export TF_STATE_REGION="nyc3"
```

## 🚀 Deployment Workflows

### Single Module Deployment

```bash
cd environments/development/nyc3/droplet

# Initialize & Validate
terragrunt init
terragrunt validate

# Plan & Apply
terragrunt plan -out=tfplan
terragrunt apply tfplan
```

### Full Environment Deployment

```bash
# Dry run
terragrunt plan -all --terragrunt-non-interactive

# Apply with approval
terragrunt apply -all --terragrunt-non-interactive
```

## 🔄 CI/CD Integration

```yaml
# .github/workflows/deploy.yml
jobs:
  deploy:
    env:
      TF_TOKEN: ${{ secrets.TF_API_TOKEN }}
    steps:
      - uses: tofu-actions/tofu@v1
        with:
          tofu_version: 1.6.0
          args: plan -out=tfplan
```

## 🏗️ Module Structure

```bash
environments/
  └── development/
      └── nyc3/
          ├── droplet/
          │   ├── terragrunt.hcl
          │   └── variables.tf
          └── vpc/
              ├── terragrunt.hcl
              └── outputs.tf
```

## 💡 Pro Tips

1. **Debugging**:

   ```bash
   TF_LOG=DEBUG terragrunt plan
   ```

2. **Targeted Operations**:

   ```bash
   terragrunt apply -target module.droplet
   ```
