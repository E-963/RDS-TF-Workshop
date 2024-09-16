resource "aws_internet_gateway" "rds-gw" {
  vpc_id = aws_vpc.postgres_vpc.id

  tags = {
    Name        = "gw-01"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
resource "aws_route_table" "rt-table" {
  vpc_id = aws_vpc.postgres_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rds-gw.id
  }
}

resource "aws_route_table_association" "rt-table-public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt-table.id
}