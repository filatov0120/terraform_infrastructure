terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

module "vpc-terraform" {
  source    = "./modules/aws_vpc"
  azs       = var.azs
  env       = var.env
  cidr_vpc  = var.cidr_vpc
  proj_name = var.proj_name
  common_tags = {
    Project     = var.proj_name,
    Environment = var.env
  }
}

module "docker_server" {
  source            = "./modules/aws_instance"
  depends_on        = [module.vpc-terraform]
  instance_name     = "${var.proj_name}_${var.env}_server"
  azs               = var.azs
  instance_type     = "t2.micro"
  root_block_size   = 10
  root_volume_type  = "gp2"
  instance_profile  = null
  security_group_id = module.vpc-terraform.security_group_id
  public_subnet_id  = module.vpc-terraform.public_subnet_id

  common_tags = {
    Name        = "${var.proj_name}_${var.env}_server"
    Project     = var.proj_name,
    Environment = var.env
  }
}