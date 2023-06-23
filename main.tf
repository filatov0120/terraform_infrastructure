terraform {

  # backend "s3" {
  #   bucket = "rdee-tf" #manual create
  #   key    = "dev/terraform.tfstate"
  #   region = "eu-central-1"
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    # cloudflare = {
    #   source  = "cloudflare/cloudflare"
    #   version = "~> 3.0"
    # }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

# provider "cloudflare" {
# }

module "vpc-terraform" {
  source              = "git@github.com:filatov0120/terraform_modules.git//aws_vpc?ref=v1.0.0"
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

module "backend_server" {
  source = "git@github.com:filatov0120/terraform_modules.git//aws_instance?ref=add-user_data"
  depends_on       = [module.vpc-terraform]
  instance_name    = "${var.proj_name}_${var.inst_name}_${var.env}"
  ami              = var.ami_ubuntu_22_04
  azs              = var.azs
  instance_type    = "t3.micro"
  root_block_size  = 10
  root_volume_type = "gp3"
  instance_profile = null
  vpc_id           = "vpc-04b650be7cc12bd88"
  cidr_vpc         = var.cidr_vpc
  allow_tcp_ports  = [80, 443, 22]
  allow_udp_ports  = []
  start_tcp_ports  = []
  end_tcp_ports    = []
  start_udp_ports  = []
  end_udp_ports    = []
  subnet_id        = "subnet-0fd6dfaa1c9b6241f"
  ssh_key          = var.ssh_key
  user_data        = file("script.sh")


  instance_tags = {
    Name        = "${var.proj_name}_${var.inst_name}_${var.env}"
    Project     = var.proj_name,
    Environment = var.env
  }
}

module "ebs_volume" {
  source    = "git@github.com:filatov0120/terraform_modules.git//aws_ebs?ref=v1.0.0"
  azs       = var.azs
  size      = 10
  type      = "gp3"
  proj_name = var.proj_name
  common_tags = {
    Name        = "${var.proj_name}_backend_server_${var.env}"
    Project     = var.proj_name,
    Environment = var.env
  }
}

# resource "cloudflare_record" "backend_server" {
#   zone_id = "b6212092982ead0e31b2ebb6dda689f0"
#   name    = "token-screener-backend"
#   value   = module.backend_server.instance_public_ip
#   type    = "A"
#   ttl     = 1
#   proxied = true
#   comment = "${var.proj_name}-backend_server"
# }
