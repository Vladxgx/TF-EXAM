output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "web_instance_public_ip" {
  value = module.web_instance.public_ip
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}
