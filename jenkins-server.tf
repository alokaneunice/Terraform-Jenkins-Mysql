#data "aws_ami" "latest-amazon-linux-image" {
#most_recent = true
#owners      = ["amazon"]
#filter {
# name   = "name"
#values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#}
#filter {
#name   = "virtualization-type"
#values = ["hvm"]
#}
#}

resource "aws_instance" "jenkinsapp-server" {
  #ami                         = data.aws_ami.latest-amazon-linux-image.id
  ami                         = ami
  instance_type               = instance_type
  key_name                    = "neem"
  subnet_id                   = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.default-sg.id]
  availability_zone           = avail_zone
  associate_public_ip_address = true
  user_data                   = file("jenkins.sh")
  tags = {
    Name = "jenkins-server"
  }
}