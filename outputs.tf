output "vpc_id" {
  value = module.vpc-terraform.vpc_id
}

output "vpc_cidr" {
  value = module.vpc-terraform.vpc_cidr
}

output "public_subnet_id" {
  value = module.vpc-terraform.public_subnet_id
}

output "private_subtet_id" {
  value = module.vpc-terraform.private_subnet_id
}

output "instance_id" {
  description = "ID of the EC instance"
  value       = module.docker_server.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of EC2 instance"
  value       = module.docker_server.instance_public_ip
}

output "instance_public_url" {
  description = "Public URL address of EC2 instance"
  value       = module.docker_server.instance_public_url
}
