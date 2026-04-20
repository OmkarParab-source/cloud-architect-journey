variable "name_prefix" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "enable_observability" {
  type = bool
}

variable "alb_arn_suffix" {
  type = string
}

variable "target_group_arn_suffix" {
  type = string
}

variable "asg_name" {
  type = string
}

variable "alb_latency_threshold_seconds" {
  type    = number
  default = null
}

variable "cpu_high_threshold" {
  type    = number
  default = null
}
