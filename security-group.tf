# Create Security Group for Jenkins (Public)
resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}

# Create Security Group for MySQL (Private)
#resource "aws_security_group" "mysql_sg" {
 # vpc_id = aws_vpc.main.id

  #ingress {
   # from_port       = 3306
   # to_port         = 3306
   # protocol        = "tcp"
  #  security_groups = [aws_security_group.jenkins_sg.id]
  #}

  #egress {
   # from_port   = 0
   # to_port     = 0
   # protocol    = "-1"
   # cidr_blocks = ["0.0.0.0/0"]
  #}

  #tags = {
  #  Name = "mysql-sg"
 # }
#}