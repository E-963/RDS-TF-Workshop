resource "aws_security_group" "postgres_db_sg" {
  name        = "postgres_db_sg"
  description = "Allow only bastion host to access RDS"
  vpc_id      = aws_vpc.postgres_vpc.id

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
    Name        = "rdsSG"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }

}

# Create Bastion Host security group
resource "aws_security_group" "bastion-host-sg" {
  name        = "bastion-host-sg"
  description = "Allow SSH to bastion host"
  vpc_id      = aws_vpc.postgres_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name        = "bastionSG"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
