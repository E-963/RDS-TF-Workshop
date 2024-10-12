resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]
  
 tags = {
    Name        = "frogtech-rds"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
