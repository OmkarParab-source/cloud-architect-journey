variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    cidr   = string
    az_key = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr   = string
    az_key = string
  }))
}
