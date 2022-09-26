
# create a vpc
resource "aws_vpc" "bianca_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.bianca_vpc_name
  }
}

resource "aws_internet_gateway" "bianca_ig" {
  vpc_id = aws_vpc.bianca_vpc.id
  tags = {
    Name = var.bianca_internet_gateway_name
  }
}
#create route_table
resource "aws_route_table" "bianca_route_table" {
  vpc_id = aws_vpc.bianca_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bianca_ig.id
  }
  tags = {
    Name = var.bianca_route_table_name
  }
}


# create public subnets

resource "aws_subnet" "bianca_public_subnet1" {
  vpc_id     = aws_vpc.bianca_vpc.id
  cidr_block = var.bianca_public_subnet1
  tags = {
    Name = var.bianca_public_subnet1_name
  }
}

resource "aws_subnet" "bianca_public_subnet2" {
  vpc_id     = aws_vpc.bianca_vpc.id
  cidr_block = var.bianca_public_subnet2
  tags = {
    Name = var.bianca_public_subnet2_name
  }
}

#create private subnets
resource "aws_subnet" "bianca_private_subnet1" {
  vpc_id     = aws_vpc.bianca_vpc.id
  cidr_block = var.bianca_private_subnet1
  tags = {
    Name = var.bianca_private_subnet1_name
  }
}

resource "aws_subnet" "bianca_private_subnet2" {
  vpc_id     = aws_vpc.bianca_vpc.id
  cidr_block = var.bianca_private_subnet2
  tags = {
    Name = var.bianca_private_subnet2_name
  }
}

#create route tables
resource "aws_route_table_association" "attach_subnets_public1" {

  subnet_id      = aws_subnet.bianca_public_subnet1.id
  route_table_id = aws_route_table.bianca_route_table.id

}

resource "aws_route_table_association" "attach_subnets_public2" {

  subnet_id      = aws_subnet.bianca_public_subnet2.id
  route_table_id = aws_route_table.bianca_route_table.id

}

#function to get ip
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

#create security groups
resource "aws_security_group" "bianca_public_security_group" {
  vpc_id = aws_vpc.bianca_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = var.protocol
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = var.protocol
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = var.bianca_public_security_group_name
  }
}

resource "aws_security_group" "bianca_private_security_group" {
  vpc_id = aws_vpc.bianca_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = var.protocol
    cidr_blocks = ["${aws_instance.bianca_instance2.private_ip}/32"]
  }
  tags = {
    Name = var.bianca_private_security_group_name
  }

}



#create instance
resource "aws_instance" "bianca_instance1" {
  ami                         = var.ami_value
  instance_type               = var.ec2_instance_type1
  subnet_id                   = aws_subnet.bianca_public_subnet1.id
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.bianca_public_security_group.id]
  key_name                    = "aws_key"
  tags = {
    Name = var.bianca_instance1_name
  }
}

resource "aws_instance" "bianca_instance2" {
  ami                         = var.ami_value
  instance_type               = var.ec2_instance_type1
  subnet_id                   = aws_subnet.bianca_public_subnet2.id
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.bianca_public_security_group.id]
  key_name                    = "aws_key"

  tags = {
    Name = var.bianca_instance2_name
  }

}

resource "aws_instance" "bianca_instance3" {
  ami                    = var.ami_value
  instance_type          = var.ec2_instance_type1
  subnet_id              = aws_subnet.bianca_private_subnet1.id
  vpc_security_group_ids = [aws_security_group.bianca_private_security_group.id]
  key_name               = "aws_key"

  tags = {
    Name = var.bianca_instance3_name
  }
}

