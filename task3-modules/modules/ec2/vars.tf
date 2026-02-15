variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "assign_public_ip" {
  type    = bool
  default = true
}

variable "region" {
  type = string
  default = "us-east-1"
}