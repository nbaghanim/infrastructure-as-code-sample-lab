module "tag_generator" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git"
  namespace   = format("kh-lab-%s", var.name)
  environment = var.name
  name        = format("DevOps-Bootcamp-%s", var.name)
  attributes  = ["public"]
  delimiter   = "_"
}

module "ec2_tag_generator" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git"
  namespace   = format("kh-lab-%s", var.name)
  environment = var.name
  name        = format("%s_ec2_instance", var.name)
  attributes  = ["public", "instance"]
  delimiter   = "_"
}

resource "aws_vpc" "lab" {
  cidr_block = "10.0.0.0/16"
  tags       = module.tag_generator.tags
}

resource "aws_internet_gateway" "lab_gateway" {
  vpc_id = aws_vpc.lab.id
  tags   = module.tag_generator.tags
}

resource "aws_route" "lab_internet_access" {
  route_table_id         = aws_vpc.lab.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab_gateway.id
}

resource "aws_subnet" "lab_subnet" {
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags                    = module.tag_generator.tags
}

resource "aws_security_group" "lab_sg" {
  name        = format("%s_%s", var.name, "http_and_ssh")
  description = "Ingress on 22+80, +egress"
  vpc_id      = aws_vpc.lab.id

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

  tags = module.tag_generator.tags
}

resource "aws_key_pair" "lab_keypair" {
  key_name   = format("%s%s", var.name, "_keypair")
  public_key = file(var.public_key_path)
}

resource "aws_instance" "lab_nodes" {
  count = 2

  instance_type          = "t3.micro"
  ami                    = lookup(var.aws_amis, var.aws_region)
  key_name               = aws_key_pair.lab_keypair.id
  vpc_security_group_ids = [aws_security_group.lab_sg.id]
  subnet_id              = aws_subnet.lab_subnet.id
  tags                   = module.ec2_tag_generator.tags

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file(var.private_key_path)
    }

    inline = [
      "cd /home/ubuntu && mkdir -p wibble && touch ./wibble/wobble.txt && sudo apt update && sudo apt install -y curl jq vim"
    ]
  }

}
