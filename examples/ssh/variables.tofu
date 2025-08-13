variable "do_token" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "ssh_keys" {
  type = list(object({
    name       = string
    public_key = string
  }))
}