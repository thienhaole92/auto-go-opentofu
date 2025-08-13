variable "do_token" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "vpc_uuid" {
  type = string
}

variable "instance_size" {
  type = string
}

variable "os_image" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}
