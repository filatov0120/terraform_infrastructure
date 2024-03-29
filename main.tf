terraform {

  backend "s3" {
    bucket = "blaze-devops-terraform-state-0120" #manual create
    key    = "dev/infrastructure/terraform.tfstate"
    region = "us-east-1"
  }

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
  source              = "git@github.com:filatov0120/terraform_modules.git//aws_vpc"
  azs                 = var.azs
  env                 = var.env
  cidr_vpc            = var.cidr_vpc
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  proj_name           = var.proj_name
  vpc_tags = {
    Project     = var.proj_name,
    Environment = var.env
  }
}

module "docker_server" {
  source            = "git@github.com:filatov0120/terraform_modules.git//aws_instance"
  depends_on        = [module.vpc-terraform]
  instance_name     = "Docker_server_${var.env}_server"
  ami               = data.aws_ami.ubuntu_server.id
  azs               = var.azs
  instance_type     = "t2.micro"
  root_block_size   = 10
  root_volume_type  = "gp2"
  instance_profile  = null
  security_group_id = module.vpc-terraform.security_group_id
  subnet_id         = module.vpc-terraform.public_subnet_id
  ssh_key           = "blaize-test"

  instance_tags = {
    Name        = "${var.proj_name}_${var.env}_server"
    Project     = var.proj_name,
    Environment = var.env
  }
}

module "mongodb_server" {
  source            = "git@github.com:filatov0120/terraform_modules.git//aws_instance"
  depends_on        = [module.vpc-terraform]
  instance_name     = "MongoDB_${var.env}_server"
  ami               = data.aws_ami.ubuntu_server.id
  azs               = var.azs
  instance_type     = "t2.micro"
  root_block_size   = 10
  root_volume_type  = "gp2"
  instance_profile  = null
  security_group_id = module.vpc-terraform.security_group_id
  subnet_id         = module.vpc-terraform.public_subnet_id
  ssh_key           = "blaize-test"

  instance_tags = {
    Name        = "MongoDB_${var.env}_server"
    Project     = var.proj_name,
    Environment = var.env
  }
}

module "redis_server" {
  source            = "git@github.com:filatov0120/terraform_modules.git//aws_instance"
  depends_on        = [module.vpc-terraform]
  instance_name     = "Redis_${var.env}_server"
  ami               = data.aws_ami.ubuntu_server.id
  azs               = var.azs
  instance_type     = "t2.micro"
  root_block_size   = 10
  root_volume_type  = "gp2"
  instance_profile  = null
  security_group_id = module.vpc-terraform.security_group_id
  subnet_id         = module.vpc-terraform.public_subnet_id
  ssh_key           = "blaize-test"

  instance_tags = {
    Name        = "Redis_${var.env}_server"
    Project     = var.proj_name,
    Environment = var.env
  }
}
