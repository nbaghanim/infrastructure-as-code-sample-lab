provider "aws" {
  profile = "default"
  region  = "me-south-1"

}

module "labs" {
  source = "./lab"
}
