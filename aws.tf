provider "aws" {  region = "us-east-1"  # Set your desired region
}
resource "aws_vpc" "my_vpc" {  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "public_subnet" {  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id  cidr_block = "10.0.2.0/24"
}
resource "aws_security_group" "instance_sg" {  name        = "instance_sg"
  description = "Security group for EC2 instance"  
  ingress {    from_port   = 22
    to_port     = 22    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  }
    egress {
    from_port   = 0    to_port     = 0
    protocol    = "-1"    cidr_blocks = ["0.0.0.0/0"]
  }}
resource "aws_instance" "ec2_instance" {
  ami           = "ami-xxxxxxxxxxxxxxxxx"  # Replace with your desired AMI ID  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id  security_groups = [aws_security_group.instance_sg.id]
    root_block_device {
    volume_size = 5    volume_type = "gp2"
  }  
  tags = {    "purpose" = "Assignment"
  }}
output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip}