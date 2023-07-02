provider "aws" {
  region = var.aws_region
}

resource "aws_launch_template" "asg_template" {
  image_id      = var.ami_id
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "asg" {
  availability_zones = ["us-east-1a", "us-east-1b"]
  desired_capacity   = var.desired_capacity
  max_size           = var.max
  min_size           = var.min

  launch_template {
    id      = aws_launch_template.asg_template.id
    version = "$Latest"
  }
}

