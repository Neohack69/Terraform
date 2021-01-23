provider "aws" {}
# AWS instance documentation ob https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "myUbuntu" {
  # To create 2 same instances
  # count = 2
  ami           = "ami-0a91cd140a1fc148a"
  instance_type = "t2.micro"
  tags = {
    Name    = "My_Ubuntu_Instance"
    Owner   = "AWS Student"
    Project = "AWS"
  }

}