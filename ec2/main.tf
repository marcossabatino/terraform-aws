provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "server" {
  ami  		= "ami-0c7c4e3c6b4941f0f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_base.id]
  key_name  	= aws_key_pair.base.key_name
  tags      	= { "name" = "ec2-base", "env" = "dev" }
}

resource "aws_key_pair" "base" {
  key_name   	= "my-key"
  public_key 	= file("~/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "sg_base" {
  name        = "sg_base"
  description = "Security Group allow SSH"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

