resource "aws_instance" "terra-admin" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "terra-key"
  vpc_security_group_ids = ["sg-03a67763bdea2b07e"]
  tags = {
    Name = "Terra-Admin"
  }
}