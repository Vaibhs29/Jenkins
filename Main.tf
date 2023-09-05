resource "aws_vpc" "MyVpc" {
    cidr_block = "15.15.0.0/16"
   
    tags = {
        Name = "MyVpc_by_Jenkins"
      
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
  
# Configure the AWS Gateway
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

resource "aws_instance" "Myinstance" {
  ami = "ami-0ded8326293d3201b"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Subnet-1.id

  tags = {
    Name="MyEC2Instant_by_Jenkins"
  }
  
}
