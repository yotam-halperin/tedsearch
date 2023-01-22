variable "region" {
  type        = string
  default     = "eu-central-1"
}

variable "vpc_name" {
  type        = map
  default     = {
    "default" = "yh-tf",
    "DEV" = "yh-tf-dev",
    "PROD" = "yh-tf-prod",
    "E2E" = "yh-tf-e2e"
  }
}


variable "instance_type" {
  type        = map
  default     = {
    "default" = "t3a.micro",
    "DEV" = "t3a.micro",
    "PROD" = "t3a.micro",
    "E2E" = "t3a.micro"
  }
}

variable "vpc_cidr" {
  type        = map
  default     = {
    "default" = "10.70.0.0/16",
    "DEV" = "10.80.0.0/16",
    "PROD" = "10.90.0.0/16",
    "E2E" = "10.60.0.0/16"
  }
}

variable "subnet_cidr" {
  type        = map
  default     = {
    "default" = "10.70.10.0/24",
    "DEV" = "10.80.10.0/24",
    "PROD" = "10.90.10.0/24",
    "E2E" = "10.60.10.0/24"
  }
}

variable "subnet_azs" {
  type        = map
  default     = {
    "default" = "eu-central-1a",
    "DEV" = "eu-central-1a",
    "PROD" = "eu-central-1a",
    "E2E" = "eu-central-1a"
  }
}

variable "instance_ami" {
  type        = string
  default     = "ami-0039da1f3917fa8e3"
  # default = "ami-01b8d743224353ffe" # eu-west-2
}


variable "instance_port" {
  type    = number
  default = 80
}
