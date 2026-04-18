output "alb_dns_name" {
  description = "Public entry point of the application"
  value       = module.networking.alb_dns_name
}
