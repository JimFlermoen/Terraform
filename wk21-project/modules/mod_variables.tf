# Variables

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  type    = string
  default = "week-21-project"
}

variable "ami_id" {
  type    = string
  default = "ami-06b09bfacae1453cb"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "asg_name" {
  type    = string
  default = "asg"
}

variable "desired_capacity" {
  type    = string
  default = "2"
}

variable "max" {
  type    = string
  default = "5"
}

variable "min" {
  type    = string
  default = "2"
}

variable "key_name" {
  type    = string
  default = "Projectkey"
}