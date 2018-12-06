
/* ------ Creating Public Subnet ----------------- */
	resource "aws_subnet" "t_subnet_public" {
	  vpc_id = "${aws_vpc.t_vpc.id}"
	  cidr_block = "10.0.1.0/24"
	  availability_zone = "us-east-2a"
	  tags {
		Name = "Terraform - PublicSubnet"
	  }
	}
	
/* ------ Route Table association with the Public Subnet 1 ----------------- */
	resource "aws_route_table_association" "t_rt_assoc" {
	  subnet_id      = "${aws_subnet.t_subnet_public.id}"
	  route_table_id = "${aws_vpc.t_vpc.default_route_table_id}"
	}
	
/* ------ Creating Public Subnet 2 ----------------- */
	resource "aws_subnet" "t_subnet_public2" {
	  vpc_id = "${aws_vpc.t_vpc.id}"
	  cidr_block = "10.0.3.0/24"
	  availability_zone = "us-east-2c"
	  tags {
		Name = "Terraform - PublicSubnet2"
	  }
	}

	
/* ------ Route Table association with the Public Subnet 2 ----------------- */
	resource "aws_route_table_association" "t_rt_assoc2" {
	  subnet_id      = "${aws_subnet.t_subnet_public2.id}"
	  route_table_id = "${aws_vpc.t_vpc.default_route_table_id}"
	}
	
	
/* ------ Creating a Private Subnet ----------------- */
	resource "aws_subnet" "t_subnet_private" {
	  vpc_id = "${aws_vpc.t_vpc.id}"
	  cidr_block = "10.0.2.0/24"
	  availability_zone = "us-east-2b"

	  tags {
		Name = "Terraform - PrivateSubnet"
	  }
	}

/* ------ Route Table association with the Private Subnet  ----------------- */
	resource "aws_route_table_association" "t_rt_assoc_private" {
	  subnet_id      = "${aws_subnet.t_subnet_private.id}"
	  route_table_id = "${aws_route_table.t_routeTablePrivate.id}"
	}
	
