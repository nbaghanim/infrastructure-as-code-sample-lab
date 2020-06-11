variable "public_key_path" {
  description = "path to public key to inject into the instances to allow ssh"
  default     = "../ssh/id_rsa.pub"
}

variable "key_name" {
  description = "master key for the lab"
  default     = "lab-key"
}

variable "name" {
  description = "A name to be applied to everythign"
  default     = "lab"
}

variable "aws_region" {
  description = "London"
  default     = "eu-west-2"
}

# Ubuntu Ubuntu Server 18.04 LTS 
variable "aws_amis" {
  description = "What to put on the servers!"
  default = {
    eu-west-2 = "ami-0d10b0466e0da977c"
  }
}
