terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>2.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.43.0"
    }
  }
}

provider "docker" {}

provider "aws" {
  region = var.aws_region
}
