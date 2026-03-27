output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "public_subnets" {
  value = {
    for name, subnet in aws_subnet.public :
    name => {
      id   = subnet.id
      az   = subnet.availability_zone
      cidr = subnet.cidr_block
    }
  }
}

output "private_subnets" {
  value = {
    for name, subnet in aws_subnet.private :
    name => {
      id   = subnet.id
      az   = subnet.availability_zone
      cidr = subnet.cidr_block
    }
  }
}
