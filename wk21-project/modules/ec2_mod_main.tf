# Create EC2 Instance
resource "aws_instance" "week-21" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id
  key_name      = var.key_name
  tags = {
    Name = var.name
  }
}
