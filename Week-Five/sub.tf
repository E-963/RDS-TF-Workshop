resource "aws_subnet" "subnet_01" {
  vpc_id            = aws_vpc.vpc_01.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"  # First AZ
  tags = {
    Name = "subnet-01"
  }
}

resource "aws_subnet" "subnet_02" {
  vpc_id            = aws_vpc.vpc_01.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"  # Second AZ
  tags = {
    Name = "subnet-02"
  }
}
