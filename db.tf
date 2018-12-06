	
/* ------ Creating DB Subnet Group  ----------------- */

	resource "aws_db_subnet_group" "dbsubnetgroup" {
	  name       = "dbsubnetgroup"
	  subnet_ids = ["${aws_subnet.t_subnet_public.id}","${aws_subnet.t_subnet_private.id}"]

	  tags {
		Name = "Terraform_DB_Subnet_Group"
	  }
	}
	
/* ------ Creating DB Instance MYSQL  ----------------- */

		resource "aws_db_instance" "default" {
		  allocated_storage    = 10
		  storage_type         = "gp2"
		  engine               = "mysql"
		  engine_version       = "5.7"
		  instance_class       = "db.t2.micro"
		  name                 = "terraform_user"
		  username             = "terraform_user"
		  password             = "terraform_user"
		  parameter_group_name = "default.mysql5.7"
		  db_subnet_group_name  = "${aws_db_subnet_group.dbsubnetgroup.id}"
		  vpc_security_group_ids = ["${aws_security_group.t_db_SG.id}"]
		  skip_final_snapshot = "true"
		}