//generate public key and private key 
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

//resource that carry public key
resource "aws_key_pair" "generated_key" {
  key_name   = "deplyer_key"
  public_key = "${tls_private_key.key.public_key_openssh}"
}

//to create secret key
  resource "aws_secretsmanager_secret" "private" {
  name = "private_key"
}

//to fill the value 
resource "aws_secretsmanager_secret_version" "test_secret" {
  secret_id     = "${aws_secretsmanager_secret.private.id}"
  secret_string = "${tls_private_key.key.private_key_pem}"
}

//save key in local file 
resource "local_file" "private_key" {
    content     = "${tls_private_key.key.private_key_pem}"
    filename = "private_key.pem"
}