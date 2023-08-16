terraform {
  backend "s3" {
    bucket = "balancee-prodstate-bucket1"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

