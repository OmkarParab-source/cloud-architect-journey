variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = map(string)
}

variable "private_subnets" {
  type = map(string)
}

variable "nat_per_az" {
  type = bool
}
