provider "aws" {
  region  = "us-east-2"
  profile = "personal"
}

module "webserver" {
  source              = "../../../modules/services/webserver"
  env                 = "stage-webserver"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
  ASG_min_size        = 2
  ASG_max_size        = 3
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
