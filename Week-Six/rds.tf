# define the RDS instance with Multi-AZ and other specifications, 
# ensure public access is denied, storage is allocated, and the correct engine version is used.

resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  instance_class         = "db.t3.micro"
  engine                 = "postgres"
  identifier             = "frogtech-rds"
  username               = "dbadmin"
  password               = "SecurePassword123!"  # Ensure it's secure
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = true

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

# Reference the same subnet or VPC
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  
  tags = {
    Name        = "frogtech-rds"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
