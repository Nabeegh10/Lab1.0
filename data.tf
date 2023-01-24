data "aws_ami" "amz-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "image-id"
    values  = ["ami-0a606d8395a538502"]
  }
}
