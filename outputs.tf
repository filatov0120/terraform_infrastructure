output "vpc_id" {
  description = "VPC id"
  value       = module.vpc-terraform.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = module.vpc-terraform.vpc_cidr
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.vpc-terraform.public_subnet_id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = module.vpc-terraform.private_subnet_id
}

output "instance_id" {
  description = "ID of the EC instance"
  value       = module.docker_server.instance_id
}

output "EIP_docker_server" {
  description = "EIP for docker_server"
  value       = module.docker_server.elastic_ip
}

output "EIP_mongodb_server" {
  description = "EIP for mongodb_server"
  value       = module.mongodb_server.elastic_ip
}

output "EIP_redis_server" {
  description = "EIP for redis_server"
  value       = module.redis_server.elastic_ip
}

output "DNS_docker_server" {
  description = "EIP for docker_server"
  value       = module.docker_server.instance_public_url_eip
}

output "DNS_mongodb_server" {
  description = "EIP for mongodb_server"
  value       = module.mongodb_server.instance_public_url_eip
}

output "DNS_redis_server" {
  description = "EIP for redis_server"
  value       = module.redis_server.instance_public_url_eip
}
