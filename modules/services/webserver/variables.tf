variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "env" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
}


variable "ASG_min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
}
variable "ASG_max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}