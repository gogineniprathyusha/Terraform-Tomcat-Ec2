terraform {
 required_providers {
     aws = {
         source = "hashicorp/aws"
         version = "~>4.0"
     }
 }
}

# Configure the AWS provider

provider "aws" {
  region     = "us-east-1"
  access_key = "my access_key"
  secret_key = "my secret_key"
}


# Create a VPC

resource "aws_vpc" "Tomcat-VPC"{
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "Tomcat-VPC"
    }

}

# Create Subnet

resource "aws_subnet" "Tomcat-Subnet1" {
    vpc_id = aws_vpc.Tomcat-VPC.id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "Tomcat-Subnet1"
    }
}

# Create Internet Gateway

resource "aws_internet_gateway" "Tomcat-IntGW" {
    vpc_id = aws_vpc.Tomcat-VPC.id

    tags = {
        Name = "Tomcat-InternetGW"
    }
}


# Create Secutity Group

resource "aws_security_group" "Tomcat_Sec_Group" {
  name = "Tomcat Security Group"
  description = "To allow inbound and outbound traffic to Tomcat"
  vpc_id = aws_vpc.Tomcat-VPC.id


}

# Create route table and association

resource "aws_route_table" "Tomcat_RouteTable" {
    vpc_id = aws_vpc.Tomcat-VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Tomcat-IntGW.id
    }

    tags = {
        Name = "Tomcat_Routetable"
    }
}

# Create route table association
resource "aws_route_table_association" "Tomcat_routetable" {
    subnet_id = aws_subnet.Tomcat-Subnet1.id
    route_table_id = aws_route_table.Tomcat_RouteTable.id
}

# Create an AWS EC2 Instance to host Tomcat

resource "aws_instance" "Tomcat" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = "Devops"
  vpc_security_group_ids = [aws_security_group.Tomcat_Sec_Group.id]
  subnet_id = aws_subnet.Tomcat-Subnet1.id
  associate_public_ip_address = true
  user_data = file("tomcat.sh")

  tags = {
    Name = "Tomcat-terraform"
  }
}
