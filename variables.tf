# variable "AWS_ACCESS_KEY" {
#      description = "Access key to AWS console"
# }
# variable "AWS_SECRET_KEY" {
#      description = "Secret key to AWS console"
# }
# variable "region" {
#      description = "Region of AWS VPC"
# }
variable "name" {
  default = "myadmin"
  type        = string
  description = "The name of the user"
}

variable "policy_arns" {
  default = "arn:aws:iam::aws:policy/AdministratorAccess"
  type        = string
  description = "ARN of policy to be associated with the created IAM user"
}

variable "bianca-public-subnet1" {
  type=string
  default = "10.0.1.0/24"
}

variable "bianca-public-subnet2" {
  type=string
  default = "10.0.2.0/24"
}

variable "bianca-private-subnet1" {
  type=string
  default = "10.0.128.0/24"
}

variable "bianca-private-subnet2" {
  type=string
  default = "10.0.129.0/24"
}