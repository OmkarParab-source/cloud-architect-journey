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

# Compute
instance_type = "t3.micro"

# ASG (lifecycle only, no scaling)
asg_min     = 1
asg_desired = 1
asg_max     = 1

target_cpu_utilization = null

# networking (cost optimized)
nat_per_az = false

# observability (informational)
enable_observability = true

alb_latency_threshold_seconds = 2
cpu_high_threshold            = 90
