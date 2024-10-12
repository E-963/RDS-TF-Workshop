# Create a VPC

resource "aws_vpc" "rds_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "vpc-01"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
  
}
# Create a public subnet for the bastion host
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.rds_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-sub-1"
    Environment = "terraformChamps"
    Owner       = "soo28"
}
}
 # Create a private subnet for the primary RDS instance
resource "aws_subnet" "rds_subnet_1" {
  vpc_id            = aws_vpc.rds_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"    #first AZ
  tags = {
    Name        = "private-sub-1"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
 
}
# Create a private subnet for the standby RDS instance
resource "aws_subnet" "rds_subnet_2" {
  vpc_id            = aws_vpc.rds_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"  #second AZ
  
  tags = {
    Name        = "private-sub-2"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
  
}
