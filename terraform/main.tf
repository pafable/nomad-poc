terraform {
  required_version = ">= 1.0.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.58.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}
