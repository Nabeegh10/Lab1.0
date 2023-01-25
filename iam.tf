resource "aws_iam_user" "sham" {
  name = "eish"
  force_destroy = true

  tags = {
    tag-key = "new-tag"
  }
}