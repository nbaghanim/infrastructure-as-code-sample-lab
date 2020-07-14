provider "aws" {
  profile = "kh-envs"
  region  = "me-south-1"
}

module "dev" {
  name            = "dev"
  source          = "./env"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}

module "test" {
  name            = "test"
  source          = "./env"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}

module "prod" {
  name            = "prod"
  source          = "./env"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}
