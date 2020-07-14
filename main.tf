provider "aws" {
  profile = "kh-envs"
  region  = "me-south-1"
}

module "dev" {
  source          = "./env"
  name            = "dev"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}

module "test" {
  source          = "./env"
  name            = "test"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}

module "prod" {
  source          = "./env"
  name            = "prod"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}

