
/* ------ Modifying the Default Security Group (Created by Default) ----------------- */
	resource "aws_default_security_group" "default" {
	  vpc_id = "${aws_vpc.t_vpc.id}"
	  ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
	  }
	  ingress {
		from_port   = "22"
		to_port     = "22"
		protocol    = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	  }
	  egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	  }

	  tags {
		Name = "Terraform-SG-Instance"
	  }
	}	

/* ------ Creating Security Group for DB Instance ----------------- */

		resource "aws_security_group" "t_db_SG" {
		  name        = "t_db_SG"
		  description = "Allow traffic on port 3306"
		  vpc_id = "${aws_vpc.t_vpc.id}"
		  
		  ingress {
			from_port   = 3306
			to_port     = 3306
			protocol    = "tcp"
			security_groups = ["${aws_default_security_group.default.id}"]
		  }

		  tags {
			Name = "Terraform-SG-DB"
		  }
		}
	