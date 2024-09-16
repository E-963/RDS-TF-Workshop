resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet_01.id, aws_subnet.subnet_02.id]

  tags = {
    Name        = "rds-subnet-group"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
resource "aws_db_instance" "postgresql" {
  allocated_storage      = 20
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  db_name                = "postgresqldatabase"
  username               = "postgres"
  password               = "ValidPassw0rd!"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sg_01.id]
  skip_final_snapshot    = true
  multi_az = false
  publicly_accessible = true
  


  tags = {
    Name        = "postgresql"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
