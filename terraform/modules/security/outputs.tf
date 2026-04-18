output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

output "ec2_security_group_id" {
  value = aws_security_group.ec2.id
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2.name
}
