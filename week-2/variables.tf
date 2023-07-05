# --Variable Child Module--

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

variable "key_name" {
  type    = string
  default = "Projectkey"
}

variable "availability_zones" {
  type    = list(string)
  default = (["us-east-1a", "us-east-1b"])
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "max" {
  type    = number
  default = 5
}

variable "min" {
  type    = number
  default = 2
}

variable "cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}