resource "aws_security_group" "sg_01" {
  name        = "sec-01"
  description = "Allow inbound 5432 and all outbound traffic"
  vpc_id      = aws_vpc.vpc_01.id

  ingress {
    from_port   = 5432
    to_port     = 5432
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
    Name        = "sg-01"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
