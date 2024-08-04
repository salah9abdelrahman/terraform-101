provider "aws" {
  region  = "us-east-2"
  profile = "personal"
}

module "webserver" {
  source              = "../../../modules/services/webserver"
  env                 = "prod-webserver"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"
}
