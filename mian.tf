resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "pub_sub1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidr_block1
    availability_zone = "us-east-1a"
    tags = {
      Name = "public_subnet1"
    }
  
}
resource "aws_subnet" "pub_sub2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidr_block2
    availability_zone = "us-east-1b"
    tags = {
      Name = "public_subnet2"
    }
  
}

resource "aws_internet_gateway" "pro_ig" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "my_igw"
    }

  
}
resource "aws_route_table" "pub_prt_rt1" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = var.route_cidr_block
        gateway_id = aws_internet_gateway.pro_ig.id
        
    }
    tags = {
        Name = "pub_route1"
    }
  
}
resource "aws_route_table" "pub_prt_rt2" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = var.route_cidr_block
        gateway_id = aws_internet_gateway.pro_ig.id
        
    }
    tags = {
        Name = "pub_route2"
    }
  
}



resource "aws_route_table_association" "pub_pro_rta1" {
    subnet_id = aws_subnet.pub_sub1.id
    route_table_id = aws_route_table.pub_prt_rt1.id
  
}
resource "aws_route_table_association" "pub_pro_rta2" {
    subnet_id = aws_subnet.pub_sub2.id
    route_table_id = aws_route_table.pub_prt_rt2.id
  
}


resource "aws_security_group" "pro_sg" {
    name = "allow_tls"
    description = "allow_tls inbound rules"
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        description = "TLS from VPC"
        from_port = var.inbound_port1
        to_port = var.inbound_port1
        protocol = var.inbound_protocol1
        cidr_blocks = [var.cidr_block_sg1]
    }
    ingress {
        description = "TLS from VPC"
        from_port = var.inbound_port2
        to_port = var.inbound_port2
        protocol = var.inbound_protocol2
        cidr_blocks = [var.cidr_block_sg2]
    }
    ingress {
        description = "TLS from VPC"
        from_port = var.inbound_port3
        to_port = var.inbound_port3
        protocol = var.inbound_protocol3
        cidr_blocks = [var.cidr_block_sg3]
    }
    egress {
        description = "TLS from VPC"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    tags = {
      Name = "allow_tls"
    }
  
}
resource "aws_instance" "pro_ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.pro_sg.id]
    subnet_id = aws_subnet.pub_sub1.id
    user_data = file("userdata.sh")
    tags = {
      Name = "Docker_server"
    }
  
}
