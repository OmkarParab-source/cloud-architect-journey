variable "region" { type = string }
variable "profile" { type = string }

variable "service" { type = string }
variable "environment" { type = string }
variable "owner" { type = string }

variable "vpc_cidr" { type = string }

variable "public_subnets" {
  type = map(string)
}

variable "private_subnets" {
  type = map(string)
}

# Compute
variable "instance_type" { type = string }

# ASG
variable "asg_min" { type = number }
variable "asg_desired" { type = number }
variable "asg_max" { type = number }

variable "target_cpu_utilization" {
  type    = number
  default = null
}

# Networking
variable "nat_per_az" {
  type = bool
}

# Observability
variable "log_retention_days" {
  type = number
}

variable "cpu_warning_threshold" {
  type    = number
  default = null
}

variable "cpu_critical_threshold" {
  type    = number
  default = null
}
