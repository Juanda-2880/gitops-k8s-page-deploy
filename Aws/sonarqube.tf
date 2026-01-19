resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube_security_group"
  description = "Allow SonarQube and SSH Traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SonarQube access"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SonarQube Security Group"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "sonarqube" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "m7i-flex.large"
  key_name      = var.key_name
  security_groups = [aws_security_group.sonarqube_sg.name]

  user_data = file("install_sonarqube.sh")

  tags = {
    Name = "SonarQube Instance"
  }
}