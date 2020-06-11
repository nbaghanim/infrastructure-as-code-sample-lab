provider "aws" {
  profile = "kh-labs"
  region  = "me-south-1"

}

module "labs" {
  source = "./lab"
}
