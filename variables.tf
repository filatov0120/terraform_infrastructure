variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "azs" {
  type        = string
  description = "Availability Zones list"
  default     = "us-east-1a"
}

variable "env" {
  description = "Name of env"
  type        = string
  default     = "DEV"
}

variable "proj_name" {
  description = "Name of project"
  type        = string
  default     = "OMOMO"
}

variable "common_tags" {
  description = "Common tags to apply to all resourses"
  type        = map(any)
  default = {
    Project     = "OMOMO"
    Environment = "DEV"
  }
}

variable "cidr_vpc" {
  description = "CIDR block for VPC"
  type        = string
  default     = "192.168.0.0/16"
}

