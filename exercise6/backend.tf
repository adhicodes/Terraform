terraform {
  backend "s3" {
    bucket = "terraformstate0711"
    key    = "terraform/backend-exer6"
    region = "us-east-1"
  }
}