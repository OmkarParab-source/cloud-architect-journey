output "alb_sg_id" {
  description = "Security Group ID for ALB"
  value       = aws_security_group.alb.id
}

output "web_sg_id" {
  description = "Security Group ID for Web Tier"
  value       = aws_security_group.web.id
}
