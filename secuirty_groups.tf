resource "aws_security_group" "http" {
  name        = "http"
  vpc_id      = "${aws_vpc.first_vpc.id}"


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_ssh" {
  name        = "private_ssh"
  vpc_id = "${aws_vpc.first_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [10.0.0.0/16]
  }
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  vpc_id = "${aws_vpc.first_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}