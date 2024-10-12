# Create Bastion Host security group
resource "aws_security_group" "bastion-host-sg" {
  name        = "postgres-bastion-host-sg" # Name of the security group for the bastion host
  description = "Allow SSH access"         # Description of what this security group is for
  vpc_id      = aws_vpc.postgres_vpc.id    # VPC where the bastion host resides

  tags = {
    Name = "allow_tls" # Tags for identification
  }
}

# Ingress rule to allow SSH access to the bastion host
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.bastion-host-sg.id # Security group for the bastion host
  from_port         = 22                                    # SSH port
  to_port           = 22                                    # To port 22 (SSH)
  ip_protocol       = "tcp"                                 # Protocol for SSH (TCP)
  cidr_ipv4         = aws_vpc.postgres_vpc.cidr_block       # Allows traffic from within the VPC

}

# Egress rule to allow all outbound traffic from the bastion host
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.bastion-host-sg.id # Security group for the bastion host
  cidr_ipv4         = aws_vpc.postgres_vpc.cidr_block       # Allow traffic to any destination
  ip_protocol       = "-1"                                  # Allow all protocols
}

# Create Security Group for RDS instance, allowing traffic from the bastion host
resource "aws_security_group" "postgres_db_sg" {
  name        = "postgres_db_sg"                    # Name of the security group for the RDS instance
  description = "Allow traffic from bastion to RDS" # Description of what this security group does
  vpc_id      = aws_vpc.postgres_vpc.id             # VPC where the RDS instance resides
}

# Ingress rule to allow traffic from the bastion host to the RDS instance on port 5432 (PostgreSQL)
resource "aws_vpc_security_group_ingress_rule" "allow_traffic_to_bastionhost" {
  security_group_id = aws_security_group.postgres_db_sg.id # Security group for the RDS instance
  cidr_ipv4         = aws_vpc.postgres_vpc.cidr_block      # Allows traffic from within the VPC
  from_port         = 5432                                 # PostgreSQL port
  ip_protocol       = "tcp"                                # Protocol for PostgreSQL (TCP)
  to_port           = 5432                                 # To port 5432 (PostgreSQL)
}

# Egress rule to allow all outbound traffic from the RDS instance
resource "aws_vpc_security_group_egress_rule" "allow_traffic_from_bastionhost" {
  security_group_id = aws_security_group.postgres_db_sg.id # Security group for the RDS instance
  cidr_ipv4         = aws_vpc.postgres_vpc.cidr_block      # Allow traffic to any destination
  ip_protocol       = "-1"                                 # Allow all protocols
}
