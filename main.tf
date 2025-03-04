# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-jenkins-mysql-vpc"
  }
}

# Create a Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "terraform-jenkins-mysql-public-subnet"
  }
}

# Create a Private Subnet
#resource "aws_subnet" "private" {
 # vpc_id            = aws_vpc.main.id
 # cidr_block        = "10.0.2.0/24"
 # availability_zone = "us-east-2"

  #tags = {
  #  Name = "terraform-jenkins-mysql-private-subnet"
 # }
#}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-jenkins-mysql-igw"
  }
}

# Create a Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-jenkins-mysql-public-route-table"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create a NAT Gateway
#resource "aws_eip" "nat" {
#}

#resource "aws_nat_gateway" "nat" {
#  allocation_id = aws_eip.nat.id
#  subnet_id    = aws_subnet.public.id

# tags = {
#  Name = "terraform-jenkins-mysql-nat-gateway"
# }
#}

# Create a Route Table for Private Subnet
#resource "aws_route_table" "private" {
# vpc_id = aws_vpc.main.id

# route {
#   cidr_block = "0.0.0.0/0"
#  nat_gateway_id = aws_nat_gateway.nat.id
# }

# tags = {
#  Name = "terraform-jenkins-mysql-private-route-table"
# }
#}

# Associate Private Subnet with Private Route Table
#resource "aws_route_table_association" "private" {
 # subnet_id      = aws_subnet.private.id
 # route_table_id = aws_route_table.private.id
#}

# Create Jenkins EC2 Instance
resource "aws_instance" "jenkins" {
  ami             = "ami-0cb91c7de36eed2cb"
  instance_type   = "t2.small"
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.jenkins_sg.name]
  key_name        = "neem"
  #availability_zone           = avail_zone
  associate_public_ip_address = true
  user_data                   = file("jenkins.sh")
  #tags = {
   # Name = "Jenkins-Server"
  }

#}

# Create MySQL EC2 Instance
#resource "aws_instance" "mysql" {
 # ami             = "ami-0cb91c7de36eed2cb"
 # instance_type   = "t2.micro"
 # subnet_id       = aws_subnet.private.id
 # security_groups = [aws_security_group.mysql_sg.name]

 # tags = {
   # Name = "MySQL-Server"
 # }

 # user_data = <<-EOF
 #             #!/bin/bash
  #            sudo yum update -y
 #             sudo yum install -y mysql-server
 #             sudo systemctl start mysqld
 #             sudo systemctl enable mysqld
 #             EOF
#}