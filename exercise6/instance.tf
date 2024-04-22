resource "aws_key_pair" "rare-key" {
  key_name   = "rarekey"
  public_key = file("rarekey.pub")
}

resource "aws_instance" "rare-web" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.rare-pub-1.id
  key_name               = aws_key_pair.rare-key.key_name
  vpc_security_group_ids = [aws_security_group.rare-sg.id]
  tags = {
    Name = "web"
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

resource "aws_ebs_volume" "rare-vol" {
  availability_zone = var.ZONE1
  size              = 3
  tags = {
    Name = "rare-vol"
  }
}

resource "aws_volume_attachment" "rare-vol-attach" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.rare-vol.id
  instance_id = aws_instance.rare-web.id
}

output "PublicIP" {
  value = aws_instance.rare-web.public_ip
}


