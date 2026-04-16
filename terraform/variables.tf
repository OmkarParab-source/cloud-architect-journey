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

# ASG
variable "asg_min" { type = number }
variable "asg_desired" { type = number }
variable "asg_max" { type = number }

# Scaling (optional)
variable "scale_out_cpu_threshold" {
  type    = number
  default = null
}

variable "scale_in_cpu_threshold" {
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
