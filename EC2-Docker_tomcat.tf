resource "aws_instance" "docker" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = "Devops"
  subnet_id = aws_subnet.Tomcat-Subnet1.id
  associate_public_ip_address = true
  user_data = file("dockerinstall.sh")
  tags = {
    Name = var.instance_type
}
}

resource "aws_instance" "Tomcat" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = "Devops"
  subnet_id = aws_subnet.Tomcat-Subnet1.id
  associate_public_ip_address = true
  user_data = file("tomcat.sh")

  tags = {
    Name = "Tomcat-terraform"
  }
}