provider "aws" {
  profile = "kh-labs"
  region  = "me-south-1"
}

module "dev" {
  name            = "dev"
  source          = "./lab"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}

module "test" {
  name            = "test"
  source          = "./lab"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}

module "prod" {
  name            = "prod"
  source          = "./lab"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}
