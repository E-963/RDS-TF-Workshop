resource "aws_s3_bucket" "terraform_state" {
  bucket = "sky-s3-main10"

  tags = {
    Name        = "TerraformStateBucket"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
