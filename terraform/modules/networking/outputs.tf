output "public_subnet_ids" {
  value = local.public_subnet_ids
}

output "private_subnet_ids" {
  value = local.private_subnet_ids
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "alb_arn_suffix" {
  value = module.alb.alb_arn_suffix
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "target_group_arn_suffix" {
  value = module.alb.target_group_arn_suffix
}
