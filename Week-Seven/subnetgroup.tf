resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "postgress_db_subnet_group"
  subnet_ids = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]

  tags = {
    Name        = "frogtech-rds"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
