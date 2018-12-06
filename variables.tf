variable "region" {
  default = "us-east-2"
}

variable "AmiLinux" {
  type = "map"
  default = {
    us-east-2 = "ami-0b59bfac6be064b78"
  }
}

variable "aws_access_key" {
  default = ""
  description = "the user aws access key"
}
variable "aws_secret_key" {
  default = ""
  description = "the user aws secret key"
}

variable "key_name" {
  default = ""
  description = "the ssh key to use in the EC2 machines"
}