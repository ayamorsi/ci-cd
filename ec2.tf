resource "aws_instance" "nginx1" {
  ami           = "ami-087c2c50437d0b80d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.public1.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}",
                            "${aws_security_group.allow_private_ssh.id}",
  tags = {
    Name = "nginx_1"
  }
}


resource "aws_instance" "nginx2" {
  ami           = "ami-087c2c50437d0b80d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.public2.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}",
                            "${aws_security_group.allow_private_ssh.id}",
  tags = {
    Name = "nginx_2"
  }
}


