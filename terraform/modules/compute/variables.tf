variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "private_subnet_ids" {
  type = map(string)
}

variable "web_sg_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}
