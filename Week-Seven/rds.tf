# Create a KMS key to encrypt the master user password for the PostgreSQL database
resource "aws_kms_key" "master_key" {
  description = "KMS key for encrypting PostgreSQL master user password" # More descriptive comment
}

# Create the PostgreSQL RDS instance
resource "aws_db_instance" "postgresql" {
  identifier                   = "frogtech-postgresql" # Unique identifier for the RDS instance
  username                     = "dbadmin"             # Master username for the database
  engine                       = "postgres"
  engine_version               = "16.4"            # Specifies the database engine (PostgreSQL)
  db_subnet_group_name          = aws_db_subnet_group.postgres_subnet_group.name
  vpc_security_group_ids        = [aws_security_group.postgres_db_sg.id]
  instance_class                = var.db_instance_class         # DB instance type (e.g., db.t3.micro)
  allocated_storage             = var.db_allocated_storage      # Allocated storage for the DB instance
  multi_az                      = true                          # Enable Multi-AZ for high availability
  publicly_accessible           = false                         # Ensures the DB is not publicly accessible
  storage_encrypted             = true                          # Enables encryption for storage
  backup_retention_period       = 7                             # Number of days to retain backups
  skip_final_snapshot           = true                          # Skips the final snapshot when deleting the DB
  copy_tags_to_snapshot         = true                          # Copies tags to snapshots
  deletion_protection           = false                         # Disables deletion protection
  allow_major_version_upgrade   = false                         # Prevents major version upgrades without manual approval
  apply_immediately             = true                          # Applies changes immediately
  auto_minor_version_upgrade    = true                          # Automatically upgrades minor versions
  manage_master_user_password   = true                          # Manages the master user password via Secrets Manager
  master_user_secret_kms_key_id = aws_kms_key.master_key.key_id # Uses KMS to encrypt the password

  # Tags for the RDS instance
  tags = {
    "Environment" = "terraformChamps"
    "Owner"       = "soo28"
  }
}

# Create a Secrets Manager secret to store the PostgreSQL password
resource "aws_secretsmanager_secret" "postgres_db_secret" {
  name        = "postgres-rds-secret-password" # Name of the secret in AWS Secrets Manager
  description = "RDS PostgreSQL password secret for the database"

  # Tags for the secret
  tags = {
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}

# Store the secret value (PostgreSQL username and password) in Secrets Manager
resource "aws_secretsmanager_secret_version" "postgres_secret_password" {
  secret_id = aws_secretsmanager_secret.postgres_db_secret.id # References the secret created earlier
  secret_string = jsonencode({                                # Encodes the secret as a JSON object
    username = "admin",                                       # The username for the PostgreSQL database
    password = "Admin1"                                       # The actual password (replace this with a secure password)
  })
}
