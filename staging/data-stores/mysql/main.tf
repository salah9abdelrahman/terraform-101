provider "aws" {
  region  = "us-east-2"
  profile = "personal"
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-101-state"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-east-2"
    profile        = "personal"
    dynamodb_table = "terraform-101-locks"
    encrypt        = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "tf-101"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "tf_101_database"

  # How should we set the username and password?
  # for now throw environment variables
  # export TF_VAR_db_username="(YOUR_DB_USERNAME)"
  # export TF_VAR_db_password="(YOUR_DB_PASSWORD)"
  username = "user"
  password = "sdf33#dfW"
}

