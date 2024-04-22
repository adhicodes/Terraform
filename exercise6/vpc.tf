resource "aws_vpc" "rare" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "rare"
  }
}

resource "aws_subnet" "rare-pub-1" {
  vpc_id                  = aws_vpc.rare.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "rare-pub-1"
  }
}

resource "aws_subnet" "rare-pub-2" {
  vpc_id                  = aws_vpc.rare.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "rare-pub-2"
  }
}

resource "aws_subnet" "rare-pub-3" {
  vpc_id                  = aws_vpc.rare.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "rare-pub-3"
  }
}

resource "aws_subnet" "rare-priv-1" {
  vpc_id                  = aws_vpc.rare.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "rare-priv-1"
  }
}

resource "aws_subnet" "rare-priv-2" {
  vpc_id                  = aws_vpc.rare.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "rare-priv-2"
  }
}

resource "aws_subnet" "rare-priv-3" {
  vpc_id                  = aws_vpc.rare.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "rare-priv-3"
  }
}

resource "aws_internet_gateway" "rare-igw" {
  vpc_id = aws_vpc.rare.id

  tags = {
    Name = "rare-IGW"
  }
}

resource "aws_route_table" "rare-pub-rt" {
  vpc_id = aws_vpc.rare.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rare-igw.id
  }
  tags = {
    Name = "rare-pub-RT"
  }
}

resource "aws_route_table_association" "rare-pub-1-a" {
  subnet_id      = aws_subnet.rare-pub-1.id
  route_table_id = aws_route_table.rare-pub-rt.id
}

resource "aws_route_table_association" "rare-pub-2-a" {
  subnet_id      = aws_subnet.rare-pub-2.id
  route_table_id = aws_route_table.rare-pub-rt.id
}

resource "aws_route_table_association" "rare-pub-3-a" {
  subnet_id      = aws_subnet.rare-pub-3.id
  route_table_id = aws_route_table.rare-pub-rt.id
}