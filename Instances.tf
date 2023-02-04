 resource "aws_instance" "my-public-instance" {
  ami                    = data.aws_ami.amz-linux-2.id
  count                  = length(var.a_zone)
  instance_type          = var.instance_type
  availability_zone      = var.a_zone[count.index]
  subnet_id              = aws_subnet.public-subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.public-security-group.id]

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

 resource "aws_db_instance" "rds_Instance" {
  allocated_storage      = 20
  max_allocated_storage  = 100
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  username               = "Admin"
  password               = "Admin12345"
  vpc_security_group_ids = [aws_security_group.private-security-group.id]
  availability_zone = var.a_zone[0]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group1.id
  skip_final_snapshot = true

} 