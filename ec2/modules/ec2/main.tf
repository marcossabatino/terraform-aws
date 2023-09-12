resource "aws_instance" "base" {
  ami = var.inst_ami
  instance_type = var.inst_type
  tags = var.tags
 }
