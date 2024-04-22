terraform {
  backend "s3" {
    bucket = "terraformstate0711"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}