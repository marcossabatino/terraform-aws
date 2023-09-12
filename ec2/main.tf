provider "aws" {
  region = "us-east-2"
}

module "server" {
  source = "./modules/ec2"
  inst_ami  = "ami-0c7c4e3c6b4941f0f"
  inst_type = "t2.micro"
  tags      = { "name" = "ec2-base", "env" = "dev" }
}

