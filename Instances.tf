resource "aws_instance" "my-public-instance" {
  ami               = data.aws_ami.amz-linux-2.id
  count             = length(var.a_zone)
  instance_type     = var.instance_type
  availability_zone = var.a_zone[count.index]
  subnet_id         = aws_subnet.public-subnet[count.index].id
  security_groups   = [aws_security_group.public-security-group.id]

  tags = {
    Name = "public Instance-${count.index}"
  }
}

/* resource "aws_instance" "my-private-instance" {
  ami               = data.aws_ami.amz-linux-2.id
  count             = length(var.a_zone)
  instance_type     = var.instance_type
  availability_zone = var.a_zone[count.index]
  subnet_id         = aws_subnet.private-subnet[count.index].id
  security_groups   = aws_security_group.private-security-group.id
  key_name          = "TerraKey"

  tags = {
    Name = "Private Instance"
  }
} */