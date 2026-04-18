output "public_subnet_ids" {
  value = local.public_subnet_ids
}

output "private_subnet_ids" {
  value = local.private_subnet_ids
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}
