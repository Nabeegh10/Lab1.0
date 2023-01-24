output "VPC" {
  value = aws_vpc.my-vpc.id
}

output "Instance-Public" {
  value = ["${aws_instance.my-public-instance.*.id}"]
}
output "SG-Private" {
  value = aws_security_group.private-security-group.name
}

output "SG-Public" {
  value = aws_security_group.public-security-group.name
}

output "subnet-public" {
  value = ["${aws_subnet.public-subnet.*.id}"]
}

output "subnet-private" {
    description = "All subnet ids that created in private"
  value = ["${aws_subnet.private-subnet.*.id}"]
}