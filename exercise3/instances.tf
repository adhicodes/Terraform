resource "aws_key_pair" "rare-key" {
  key_name   = "rarekey"
  public_key = file("rarekey.pub")
}

resource "aws_instance" "terra-admin" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.rare-key.key_name
  vpc_security_group_ids = ["sg-03a67763bdea2b07e"]
  tags = {
    Name = "Terra-Admin"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("rarekey")
    host        = self.public_ip
  }
}