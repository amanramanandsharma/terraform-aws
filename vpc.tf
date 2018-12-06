
/* ------ Credentials and Default values ----------------- */
	provider "aws" {
	  access_key = "${var.aws_access_key}"
	  secret_key = "${var.aws_secret_key}"
	  region     = "${var.region}"
	}

/* ------ Creating a VPC ----------------- */
	resource "aws_vpc" "t_vpc" {
	  cidr_block       = "10.0.0.0/16"
		enable_dns_support = true
		enable_dns_hostnames = true
	  tags {
		Name = "Terrafom_VPC"
	  }
	}

	
/* ------- Creating An Internet Gateway in the VPC ------- */
	resource "aws_internet_gateway" "t_igw" {
	  vpc_id = "${aws_vpc.t_vpc.id}"
	  tags {
		Name = "Terraform-IG"
	  }
	}

/* ------- Modifying the default Network Access Control List  (Created by Default) ------- */

	resource "aws_default_network_acl" "default" {
	default_network_acl_id = "${aws_vpc.t_vpc.default_network_acl_id}"
	subnet_ids = [ "${aws_subnet.t_subnet_public.id}","${aws_subnet.t_subnet_public2.id}" ]
		  egress {
			protocol = "-1"
			rule_no = 2
			action = "allow"
			cidr_block =  "0.0.0.0/0"
			from_port = 0
			to_port = 0
		}
		
		ingress {
			protocol = "-1"
			rule_no = 1
			action = "allow"
			cidr_block =  "0.0.0.0/0"
			from_port = 0
			to_port = 0
		}

		  tags {
			Name = "Terraform-NACL"
		  }
		}


/* ------- Modifying the Default Routing Table for Public Subnets (Created by Default) ------- */

		resource "aws_default_route_table" "t_routeTable" {
		default_route_table_id = "${aws_vpc.t_vpc.default_route_table_id}"
		
			route {
				cidr_block = "0.0.0.0/0"
				gateway_id = "${aws_internet_gateway.t_igw.id}"
			  }

		  tags {
			Name = "Terraform-RouteTable-Public"
		  }
		}
		
		
/* ------- Creating the Routing Table for Private Subnets ------- */

		resource "aws_route_table" "t_routeTablePrivate" {
		  vpc_id = "${aws_vpc.t_vpc.id}"

		  tags {
			Name = "Terraform-RouteTable-Private"
		  }
		}
		