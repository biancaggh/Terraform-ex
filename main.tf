
# create a vpc
resource "aws_vpc" "bianca-vpc" {
  cidr_block = "10.0.0.0/16"
  # instance_tenancy = default
  # tags = {
  #   Name = "bianca-app-vpc"
  # }
}

resource "aws_internet_gateway" "bianca-ig" {
  vpc_id = aws_vpc.bianca-vpc.id
  # tags = {
  #   Name        = "${var.environment}-igw"
  #   Environment = var.environment
  # }
}

# # Elastic-IP (eip) for NAT
# resource "aws_eip" "bianca-nat-eip" {
#   vpc        = true
#   depends_on = aws_internet_gateway.id
# }

# # NAT
# resource "aws_nat_gateway" "bianca-nat" {
#   allocation_id = aws_eip.nat_eip.id
#   #subnet_id     = element(aws_subnet.biaca-public-subnet.*.id, 0)

#   # tags = {
#   #   Name        = "nat"
#   #   Environment = "${var.environment}"
#   # }
# }


# create public subnets

resource "aws_subnet" "bianca-public-subnet1" {
  vpc_id = aws_vpc.bianca-vpc.id
  cidr_block = var.bianca-public-subnet1
}

resource "aws_subnet" "bianca-public-subnet2" {
  vpc_id = aws_vpc.bianca-vpc.id
  cidr_block = var.bianca-public-subnet2
}
resource "aws_subnet" "bianca-private-subnet1" {
  vpc_id = aws_vpc.bianca-vpc.id
  cidr_block = var.bianca-private-subnet1
}

resource "aws_subnet" "bianca-private-subnet2" {
  vpc_id = aws_vpc.bianca-vpc.id
  cidr_block = var.bianca-private-subnet2
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "bianca-sg1" {
  vpc_id = aws_vpc.bianca-vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "bianca-sg2" {
  vpc_id = aws_vpc.bianca-vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
  }

}



#create instance
resource "aws_instance" "bianca-instance1" {
  ami = "ami-05fa00d4c63e32376"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.bianca-public-subnet1.id
  associate_public_ip_address= "true"
  vpc_security_group_ids = [aws_security_group.bianca-sg1.id]
  
}

resource "aws_instance" "bianca-instance2" {
  ami = "ami-05fa00d4c63e32376"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.bianca-public-subnet2.id
  associate_public_ip_address= "true"
  vpc_security_group_ids = [aws_security_group.bianca-sg1.id]

}

resource "aws_instance" "bianca-instance3" {
  ami = "ami-05fa00d4c63e32376"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.bianca-private-subnet1.id
  vpc_security_group_ids = [aws_security_group.bianca-sg2.id]
}

