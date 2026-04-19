region  = "ap-south-1"
profile = "terraform"

service     = "cloud-arch"
environment = "staging"
owner       = "omkar"

vpc_cidr = "10.2.0.0/16"

public_subnets = {
  "ap-south-1a" = "10.2.1.0/24"
  "ap-south-1b" = "10.2.3.0/24"
}

private_subnets = {
  "ap-south-1a" = "10.2.2.0/24"
  "ap-south-1b" = "10.2.4.0/24"
}

# Compute
instance_type = "t3.small"

# ASG (production-like behavior)
asg_min     = 2
asg_desired = 2
asg_max     = 4

target_cpu_utilization = 65

# networking (production simulation)
nat_per_az = true

# observability (near-production)
log_retention_days     = 14
cpu_warning_threshold  = 70
cpu_critical_threshold = 85
