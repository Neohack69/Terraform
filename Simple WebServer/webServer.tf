provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "myUbuntu" {
  ami           = "ami-0a91cd140a1fc148a" # Ubuntu
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.myWebServer.id]
  user_data = <<EOF
  #!/bin/bash
  apt-get update
  apt-get install httpd
  echo "<h1>My first automated WebServer!!!<h1>" > /var/www/html/index.html
  sudo service httpd start
  chkconfig httpd on
  EOF
  tags = {
    Name    = "MySimpleWebServer"
    Owner   = "AWS Student"
    Project = "Learning Terraform"
  }
}

resource "aws_security_group" "myWebServer" {
  name        = "WebServer SG"
  description = "Allow TLS inbound traffic"

  ingress { # incoming traffic
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { # incoming traffic
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { # outgoing traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}