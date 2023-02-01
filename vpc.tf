# Creating my own VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = var.cidr

  tags = {
    "Name" = "my-vpc"
  }
}

# Creating public subnet
resource "aws_subnet" "public-subnet" {
  count             = length(var.a_zone)
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = element(var.public_subnet, count.index)
  availability_zone = element(var.a_zone, count.index)

  tags = {
    Name = "Public Subnet"
  }
}

# Creating private subnet
resource "aws_subnet" "private-subnet" {
  count             = length(var.a_zone)
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = element(var.private_subnet, count.index)
  availability_zone = element(var.a_zone, count.index)
  tags = {
    Name = "Private Subnet"
  }
}

# creating security groups
resource "aws_security_group" "private-security-group" {
  name        = "Private SG"
  description = "Allow traffic from public subnet"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.private_subnet[0]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Private SG"
  }
}

resource "aws_security_group" "public-security-group" {
  name        = "Public SG"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Public SG"
  }
}

resource "aws_db_subnet_group" "db_subnet_group1" {
  name       = "main-db-subnet"
  subnet_ids = [aws_subnet.private-subnet.id]

  tags = {
    Name = "My DB subnet group"
  }
}