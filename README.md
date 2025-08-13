# auto-go-opentofu

**auto-go-opentofu** is a collection of Infrastructure-as-Code (IaC) configurations designed to automate the provisioning and management of infrastructure on **DigitalOcean** using [OpenTofu](https://opentofu.org/) and Terragrunt.

## Prerequisites

To use this repository, you'll want to make sure you have the following installed:

- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [OpenTofu](https://opentofu.org/docs/intro/install/) (or [Terraform](https://developer.hashicorp.com/terraform/install))
- [Go](https://go.dev/doc/install)

To simplify the process of installing these tools, you can install [mise](https://mise.jdx.dev/), then run the following to concurrently install all the tools you need, pinned to the versions they were tested with (as tracked in the [mise.toml](./mise.toml) file):

```bash
mise install
```
