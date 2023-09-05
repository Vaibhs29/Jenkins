resource "aws_vpc" "MyVpc" {
    cidr_block = "15.15.0.0/16"
   
    tags = {
        Name = "MyVpc"
      
    }
  }
  resource "aws_subnet" "Subnet-1" {
    vpc_id = aws_vpc.MyVpc.id
    cidr_block = "15.15.1.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "Subnet-1"
      
    }
    
  }
  resource "aws_internet_gateway" "My_IGW" {
    vpc_id = aws_vpc.MyVpc.id

     tags = {
        Name = "My_IGW"
      
    }
  }
  resource "aws_route" "MRT" {
    route_table_id = aws_vpc.MyVpc.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.My_IGW.id

  
  }


resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
   subnet_id = aws_subnet.Subnet-1.id
   count = 2

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "state"
    values = ["available"]
  }
}





