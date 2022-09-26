
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami_value" {
  type    = string
  default = "ami-05fa00d4c63e32376"
}

variable "ec2_instance_type1" {
  type    = string
  default = "t3.micro"
}

variable "route_table_id" {
  type    = string
  default = "rtb-656C65616E6F72"
}
variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
variable "bianca_public_subnet1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "bianca_public_subnet2" {
  type    = string
  default = "10.0.2.0/24"
}

variable "bianca_private_subnet1" {
  type    = string
  default = "10.0.128.0/24"
}

variable "bianca_private_subnet2" {
  type    = string
  default = "10.0.129.0/24"
}

variable "bianca_vpc_name" {
  type    = string
  default = "bianca_vpc"
}

variable "bianca_internet_gateway_name" {
  type    = string
  default = "bianca_internet_gateway"
}

variable "bianca_route_table_name" {
  type    = string
  default = "bianca_route_table"
}

variable "bianca_public_subnet1_name" {
  type    = string
  default = "bianca_public_subnet_1"
}

variable "bianca_public_subnet2_name" {
  type    = string
  default = "bianca_public_subnet_2"
}

variable "bianca_private_subnet1_name" {
  type    = string
  default = "bianca_private_subnet_1"
}

variable "bianca_private_subnet2_name" {
  type    = string
  default = "bianca_private_subnet_2"
}

variable "bianca_public_security_group_name" {
  type    = string
  default = "bianca_security_group_public"
}

variable "bianca_private_security_group_name" {
  type    = string
  default = "bianca_security_group_private"
}

variable "bianca_instance1_name" {
  type    = string
  default = "bianca_ec2_instante_public_1"
}

variable "bianca_instance2_name" {
  type    = string
  default = "bianca_ec2_instante_public_2"
}

variable "bianca_instance3_name" {
  type    = string
  default = "bianca_ec2_instante_private_1"
}

variable "protocol" {
  type    = string
  default = "tcp"
}