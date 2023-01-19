variable "region" {
  type    = string
  default = "eu-central-1"
  # default = "eu-west-2"
}

variable "vpc_name" {
  type    = string
  default = "yh-tf"
}


variable "vpc_cidr" {
  type    = string
  default = "10.70.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.70.10.0/24"
}

variable "subnet_azs" {
  type    = string
  default = "eu-central-1a"
}

variable "instance_ami" {
  type    = string
  default = "ami-0039da1f3917fa8e3" # eu-central-1
  # default = "ami-01b8d743224353ffe" # eu-west-2
}

variable "instance_type" {
  type    = string
  default = "t3a.small"
}

variable "instance_port" {
  type    = number
  default = 80
}
