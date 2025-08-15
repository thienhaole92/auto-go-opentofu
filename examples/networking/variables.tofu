variable "do_token" {
  type = string
}

variable "tags" {
  type = list(string)
}

variable "ssh_allowed" {
  type = list(string)
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "allowed_tcp_ports" {
  type = list(number)
}
