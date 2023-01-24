variable "instance_type" {
  default = "t2.micro"
}

variable "cidr" {
}

variable "public_subnet" {
  type = list(string)
}

variable "private_subnet" {
  type = list(string)
}

/* variable "ami" {
    type = string
} */

variable "region" {
  default = "us-east-2"
}

variable "a_zone" {
  type = list(string)
}

