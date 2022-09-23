
# create a vpc
resource "aws_vpc" "bianca-vpc" {
  cidr_block = var.vpc-cidr-block
  tags = {
    Name = "bianca-vpc"
  }
}

resource "aws_internet_gateway" "bianca-ig" {
  vpc_id = aws_vpc.bianca-vpc.id
  tags = {
    Name = "bianca-internet-gateway"
  }
}
#create route-table
resource "aws_route_table" "bianca-route-table" {
  vpc_id = aws_vpc.bianca-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.bianca-ig.id}"
  }
  tags = {
    Name = "bianca-route-table"
  }
}

# resource "aws_route_table_association" "attach-subnets" {

#     count          = length(var.subnet_cidr)
#     subnet_id      = element("${aws_subnet.${count.index}.id}" , count.index)
#     route_table_id = aws_route_table.bianca-route-table.id

# }



# create public subnets

resource "aws_subnet" "bianca-public-subnet1" {
  vpc_id     = aws_vpc.bianca-vpc.id
  cidr_block = var.bianca-public-subnet1
  tags = {
    Name = "bianca-public-subnet-1"
  }
}

resource "aws_subnet" "bianca-public-subnet2" {
  vpc_id     = aws_vpc.bianca-vpc.id
  cidr_block = var.bianca-public-subnet2
  tags = {
    Name = "bianca-public-subnet-2"
  }
}
resource "aws_subnet" "bianca-private-subnet1" {
  vpc_id     = aws_vpc.bianca-vpc.id
  cidr_block = var.bianca-private-subnet1
  tags = {
    Name = "bianca-private-subnet-1"
  }
}

resource "aws_subnet" "bianca-private-subnet2" {
  vpc_id     = aws_vpc.bianca-vpc.id
  cidr_block = var.bianca-private-subnet2
  tags = {
    Name = "bianca-private-subnet-2"
  }
}

resource "aws_route_table_association" "attach-subnets-public1" {

  subnet_id      = aws_subnet.bianca-public-subnet1.id
  route_table_id = aws_route_table.bianca-route-table.id

}

resource "aws_route_table_association" "attach-subnets-public2" {

  subnet_id      = aws_subnet.bianca-public-subnet2.id
  route_table_id = aws_route_table.bianca-route-table.id

}

resource "aws_route_table_association" "attach-subnets-private1" {

  subnet_id      = aws_subnet.bianca-private-subnet1.id
  route_table_id = aws_route_table.bianca-route-table.id

}

resource "aws_route_table_association" "attach-subnets-private2" {

  subnet_id      = aws_subnet.bianca-private-subnet2.id
  route_table_id = aws_route_table.bianca-route-table.id

}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "bianca-sg1" {
  vpc_id = aws_vpc.bianca-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "bianca-security-group-public"
  }
}

resource "aws_security_group" "bianca-sg2" {
  vpc_id = aws_vpc.bianca-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
    #cidr_blocks = ["${aws_instance.bianca-instance2.private_ip}"]
  }
  tags = {
    Name = "bianca-security-group-private"
  }

}



#create instance
resource "aws_instance" "bianca-instance1" {
  ami                         = var.ami-value
  instance_type               = var.ec2-instance-type1
  subnet_id                   = aws_subnet.bianca-public-subnet1.id
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.bianca-sg1.id]
  tags = {
    Name = "bianca-ec2-instante-public-1"
  }
}

resource "aws_instance" "bianca-instance2" {
  ami                         = var.ami-value
  instance_type               = var.ec2-instance-type1
  subnet_id                   = aws_subnet.bianca-public-subnet2.id
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.bianca-sg1.id]
  tags = {
    Name = "bianca-ec2-instante-public-2"
  }

}

resource "aws_instance" "bianca-instance3" {
  ami                    = var.ami-value
  instance_type          = var.ec2-instance-type1
  subnet_id              = aws_subnet.bianca-private-subnet1.id
  vpc_security_group_ids = [aws_security_group.bianca-sg2.id]
  tags = {
    Name = "bianca-ec2-instante-private-1"
  }
}

