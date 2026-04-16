region  = "ap-south-1"
profile = "terraform"

service     = "cloud-arch"
environment = "dev"
owner       = "omkar"

vpc_cidr = "10.0.0.0/16"

public_subnets = {
  "ap-south-1a" = "10.0.1.0/24"
}

private_subnets = {
  "ap-south-1a" = "10.0.2.0/24"
}

# ASG (lifecycle only, no scaling)
asg_min     = 1
asg_desired = 1
asg_max     = 1

scale_out_cpu_threshold = null
scale_in_cpu_threshold  = null

# networking (cost optimized)
nat_per_az = false

# observability (informational)
log_retention_days     = 3
cpu_warning_threshold  = 85
cpu_critical_threshold = 95
