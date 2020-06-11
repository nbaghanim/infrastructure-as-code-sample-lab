provider "aws" {
  profile = "kh-labs"
  region  = "me-south-1"
}

module "labs" {
  source          = "./lab"
  name            = var.name
  key_name        = var.key_name
  public_key_path = var.public_key_path
}
