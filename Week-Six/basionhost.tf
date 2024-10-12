# Generate a new SSH key pair
resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the key to AWS as a Key Pair
resource "aws_key_pair" "generated_key" {
  key_name   = "my-ssh-key"
  public_key = tls_private_key.rsa-4096.public_key_openssh
}

resource "aws_instance" "bastion" {
  ami                         = "ami-0a0e5d9c7acc336f1"  # Amazon Ubuntu 22.04 AMI in us-east-1
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = "my-ssh-key"
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]

  tags = {
     Name       = "bastion-inst"
    Environment = "terraformChamps"
    Owner       = "soo28"
  }
}
