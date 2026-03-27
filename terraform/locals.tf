locals {
  project     = "pr1"
  environment = "dev"

  common_tags = {
    Project     = local.project
    Environment = local.environment
    System      = "cloud-architect-journey"
    ManagedBy   = "terraform"
    Owner       = "omkar"
  }
}
