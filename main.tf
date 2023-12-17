provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"

  user_data  = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = "my-first-terraform-instance"
  }
}

resource "aws_security_group" "instance" {
  name = "my-first-terraform-aws_security_group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}