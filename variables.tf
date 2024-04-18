variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR Block"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "availability_zones" {
  type    = string
  default = "us-east-1a"
}