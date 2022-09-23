# variable "AWS_ACCESS_KEY" {
#      description = "Access key to AWS console"
# }
# variable "AWS_SECRET_KEY" {
#      description = "Secret key to AWS console"
# }
variable "region" {
  type    = string
  default = "us-east-1"
}
# variable "name" {
#   default = "myadmin"
#   type        = string
#   description = "The name of the user"
# }

# variable "policy_arns" {
#   default = "arn:aws:iam::aws:policy/AdministratorAccess"
#   type        = string
#   description = "ARN of policy to be associated with the created IAM user"
# }

variable "ami-value" {
  type    = string
  default = "ami-05fa00d4c63e32376"
}

variable "ec2-instance-type1" {
  type    = string
  default = "t3.micro"
}

variable "route-table-id" {
  type    = string
  default = "rtb-656C65616E6F72"
}
variable "subnet_cidr" {
  type    = list(string)
  default = ["bianca-public-subnet1", "bianca-public-subnet2", "bianca-private-subnet1", "bianca-private-subnet2"]
}

variable "vpc-cidr-block" {
  type    = string
  default = "10.0.0.0/16"
}
variable "bianca-public-subnet1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "bianca-public-subnet2" {
  type    = string
  default = "10.0.2.0/24"
}

variable "bianca-private-subnet1" {
  type    = string
  default = "10.0.128.0/24"
}

variable "bianca-private-subnet2" {
  type    = string
  default = "10.0.129.0/24"
}