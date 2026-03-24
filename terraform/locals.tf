locals {
  common_tags = {
    Project   = "cloud-architect-journey"
    Env       = var.env
    ManagedBy = "terraform"
    Owner     = "omkar"
  }
}
