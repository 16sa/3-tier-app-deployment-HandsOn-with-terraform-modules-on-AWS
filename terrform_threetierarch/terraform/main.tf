terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.region

  assume_role {
    role_arn = "arn:aws:iam::USER_ACCOUNT_ID:role/TerraformRole" # Replace with your TerraformRole ARN
    session_name = "TerraformSession" # You can change this if needed
}
}
