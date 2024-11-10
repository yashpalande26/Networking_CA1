# Define the AWS provider and region
provider "aws" {
  region = "eu-west-1"  # Specify your preferred AWS region
}

# Create a Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP access"

  # Inbound rule to allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all IPs for now, can be restricted as needed
  }

  # Inbound rule to allow HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with your own public key file
}

# Create an EC2 instance
resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = "subnet-0dedbef8238ff5f59"  # Replace with your subnet ID
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.my_key_pair.key_name  # Reference the key pair here

  associate_public_ip_address = true  # Associate public IP with the instance

  tags = {
    Name = "DockerWebServer"
  }
}
