provider "aws" {
  region = var.aws_region
}


# Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}


#Deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  vpc_id            = var.vpc_id
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

  tags = {
    Name = var.name
  }
}

#Deploy the public subnets
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  vpc_id                  = var.vpc_id
  availability_zone       = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name = var.name
  }
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.0"

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id

  tags = {
    Name = var.name
  }
}

module "wk_21_auto_scaling_group" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.10.0"

  # Autoscaling group
  name = var.name

  min_size           = var.min
  max_size           = var.max
  desired_capacity   = var.desired_capacity
  availability_zones = ["us-east-1a", "us-east-1b"]

  # Launch template
  launch_template_name = var.name

  image_id      = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.name
  }
}