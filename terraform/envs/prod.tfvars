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

# Compute
instance_type = "t3.small"

# ASG (SLA-driven)
asg_min     = 2
asg_desired = 3
asg_max     = 6

target_cpu_utilization = 60

# networking (HA where justified)
nat_per_az = true

# observability (strict and actionable)
enable_observability = true

alb_latency_threshold_seconds = 0.5
cpu_high_threshold            = 75
