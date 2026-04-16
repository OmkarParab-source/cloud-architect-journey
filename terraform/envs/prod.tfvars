region  = "ap-south-1"
profile = "terraform"

service     = "cloud-arch"
environment = "prod"
owner       = "omkar"

vpc_cidr = "10.3.0.0/16"

public_subnets = {
  "ap-south-1a" = "10.3.1.0/24"
  "ap-south-1b" = "10.3.3.0/24"
}

private_subnets = {
  "ap-south-1a" = "10.3.2.0/24"
  "ap-south-1b" = "10.3.4.0/24"
}

# ASG (SLA-driven)
asg_min     = 2
asg_desired = 3
asg_max     = 6

scale_out_cpu_threshold = 60
scale_in_cpu_threshold  = 40

# networking (HA where justified)
nat_per_az = true

# observability (strict and actionable)
log_retention_days     = 30
cpu_warning_threshold  = 75
cpu_critical_threshold = 90
