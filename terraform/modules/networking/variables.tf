variable "vpc_id" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "public_subnets" {
  type = list(object({
    name   = string
    cidr   = string
    az_key = string
  }))
}

variable "private_subnets" {
  type = list(object({
    name   = string
    cidr   = string
    az_key = string
  }))
}
