variable "aws_access_key" {
  type = string
  description = "Your AWS Access key"
}

variable "aws_secret_key" {
  type = string
  description = "Your AWS Secret key"
}

variable "db_password" {
  type = string
  description = "Your AWS Secret key"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "ap-northeast-2"
}
