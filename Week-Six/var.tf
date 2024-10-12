# Define Variables

variable "region" {
  default = "us-east-1"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  default = 20
}

variable "db_engine_version" {
  default = "15.2"
}
