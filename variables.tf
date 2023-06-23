variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "azs" {
  type        = string
  description = "Availability Zones list"
  default     = "eu-central-1a"
}

variable "ami_ubuntu_22_04" {
  description = "ami_ubuntu_22.04"
  default     = "ami-0ec7f9846da6b0f61"
}

variable "env" {
  description = "Name of env"
  type        = string
  default     = "DEV"
}

variable "proj_name" {
  description = "Name of project"
  type        = string
  default     = "rdee"
}

variable "cidr_vpc" {
  description = "CIDR block for VPC"
  type        = string
  default     = "192.173.0.0/16"
}

variable "private_subnet_cidr" {
  description = "Public subnet CIDR"
  default     = "192.173.11.0/24"
}

variable "ssh_key" {
  description = "SSH key pair for instances"
  default     = "blaize-test"
}

variable "inst_name" {
  description = "Name for instances"
  type        = string
  default     = "test"
}

variable "common_tags" {
  description = "Common tags to apply to all resourses"
  type        = map(any)
  default = {
    Project     = "rdee"
    Environment = "DEV"
  }
}
