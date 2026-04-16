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

# ASG (production-like behavior)
asg_min     = 2
asg_desired = 2
asg_max     = 4

scale_out_cpu_threshold = 60
scale_in_cpu_threshold  = 40

# networking (production simulation)
nat_per_az = true

# observability (near-production)
log_retention_days     = 14
cpu_warning_threshold  = 70
cpu_critical_threshold = 85
