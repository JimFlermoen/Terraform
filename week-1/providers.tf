# Providers

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }
  }
}

terraform {
  backend "local" {
    path = "mystate/terraform.tfstate"
  }
}