# Provider Block
provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

data "aws_ami" "ubuntu" {

  filter {
    name   = "name"
    values = ["bootcamp32-packer-ubuntu-ami-2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["587724341093"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}