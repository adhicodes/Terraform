provider "aws" {
    region = "us-east-1"
#   access_key = ""
#   secret_ket = ""
}

resource "aws_instance" "intro" {
    ami = "ami-051f8a213df8bc089"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    key_name = "terra-key"
    vpc_security_group_ids = ["sg-03a67763bdea2b07e"]
    tags = {
        Name = "Terra-Admin"
    }
}