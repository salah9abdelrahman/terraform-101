provider "aws" {
  region = "us-east-2"
  profile = "personal"
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-101-state"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-2"
    profile        = "personal"
    dynamodb_table = "terraform-101-locks"
    encrypt        = true
  }
}


resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
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
    from_port = var.server_port
    to_port   = var.server_port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "example" {
  image_id      = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }

  availability_zones = ["us-east-2a"]

}
