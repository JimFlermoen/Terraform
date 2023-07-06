

# AWS Region
provider "aws" {
  region = var.aws_region
}

# Data To Get Default Vpc 
data "aws_vpc" "default" {
  default = true
}

# Create Launch Template Resource Block
resource "aws_launch_template" "asg_template" {
  name                   = "asg_template"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.asg_sg.id]
  user_data              = file("script.sh")

  tags = {
    Name = var.name
  }
}

# Create ASG Resource Block
resource "aws_autoscaling_group" "asg" {
  name               = "asg"
  availability_zones = var.availability_zones
  desired_capacity   = var.desired_capacity
  max_size           = var.max
  min_size           = var.min

  launch_template {
    id      = aws_launch_template.asg_template.id
    version = aws_launch_template.asg_template.latest_version
  }
}

# Create Security Group Block
resource "aws_security_group" "asg_sg" {
  name        = "asg_sg"
  description = "Allow web traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  ingress {
    description = "Allow port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }

  tags = {
    Name = var.name
  }

  lifecycle {
    create_before_destroy = true
  }
}
# Security-Group Module
module "security-group" {
  source  = "./security-group"

}