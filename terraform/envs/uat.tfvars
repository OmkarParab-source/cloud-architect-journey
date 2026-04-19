region  = "ap-south-1"
profile = "terraform"

service     = "cloud-arch"
environment = "uat"
owner       = "omkar"

vpc_cidr = "10.1.0.0/16"

public_subnets = {
  "ap-south-1a" = "10.1.1.0/24"
  "ap-south-1b" = "10.1.3.0/24"
}

private_subnets = {
  "ap-south-1a" = "10.1.2.0/24"
  "ap-south-1b" = "10.1.4.0/24"
}

# Compute
instance_type = "t3.micro"

# ASG (behavior validation)
asg_min     = 2
asg_desired = 2
asg_max     = 3

target_cpu_utilization = 70

# networking (intentional single point of failure)
nat_per_az = false

# observability (behavior visibility)
log_retention_days     = 7
cpu_warning_threshold  = 75
cpu_critical_threshold = 85
