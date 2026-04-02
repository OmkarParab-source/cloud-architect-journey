variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "target_group_arn_suffix" {
  type = string
}

variable "alb_arn_suffix" {
  type = string
}
