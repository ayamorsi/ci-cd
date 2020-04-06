//create vpc 
resource "aws_vpc" "first_vpc" {
     cidr_block = "${var.cidr}"
     tags = {
         Name = "${var.tag}"
     }
 }

//gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.first_vpc.id}"

  tags = {
    Name = "main"
  }
}

//private subnet 1
 resource "aws_subnet" "private1" {
  vpc_id     = "${aws_vpc.first_vpc.id}"
  cidr_block = "${var.privatesub1}"
  availability_zone = "${var.az1}"
  tags = {
    Name = "private_Subnet1"
  }
}

//private subnet 2
resource "aws_subnet" "private2" {
  vpc_id     = "${aws_vpc.first_vpc.id}"
  cidr_block = "${var.privatesub2}"
  availability_zone = "${var.az2}"
  tags = {
    Name = "private_Subnet2"
  }
}

//route table for private subnets
resource "aws_route_table" "route_for_private" {
    vpc_id = "${aws_vpc.first_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "private_Subnet"
    }
}

//associate private subnet 1
resource "aws_route_table_association" "associate-private1" {
    subnet_id = "${aws_subnet.private1.id}"
    route_table_id = "${aws_route_table.route_for_private.id}"
}

//associate private subnet2
resource "aws_route_table_association" "associate-private2" {
    subnet_id = "${aws_subnet.private2.id}"
    route_table_id = "${aws_route_table.route_for_private.id}"
}

//public subnet 1
resource "aws_subnet" "public1" {
  vpc_id     = "${aws_vpc.first_vpc.id}"
  cidr_block = "${var.publicsub1}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.az1}"
  tags = {
    Name = "public_Subnet1"
  }
}

//public subnet 2
resource "aws_subnet" "public2" {
  vpc_id     = "${aws_vpc.first_vpc.id}"
  cidr_block = "${var.publicsub1}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.az2}"
  tags = {
    Name = "public_Subnet2"
  }
} 

//route table for public subnets 
resource "aws_route_table" "route_for_public" {
    vpc_id = "${aws_vpc.first_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "Public_Subnet"
    }
}

resource "aws_route_table_association" "associate_public1" {
    subnet_id = "${aws_subnet.public1.id}"
    route_table_id = "${aws_route_table.route_for_public.id}"
}

resource "aws_route_table_association" "associate_public2" {
    subnet_id = "${aws_subnet.public2.id}"
    route_table_id = "${aws_route_table.route_for_public.id}"
}
