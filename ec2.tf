
/* ------ Creating EC2 Instance ----------------- */

	resource "aws_instance" "phpapp" {
	  ami           = "${lookup(var.AmiLinux, var.region)}"
	  instance_type = "t2.micro"
	  associate_public_ip_address = "true"
	  subnet_id = "${aws_subnet.t_subnet_public.id}"
	  iam_instance_profile  = "${aws_iam_instance_profile.s3_access.name}"
	  vpc_security_group_ids = ["${aws_default_security_group.default.id}"]
	  key_name = "${var.key_name}"
	    user_data = <<HEREDOC
			  #!/bin/bash
			  yum update -y
			  yum install -y httpd24 php56 php56-mysqlnd
			  service httpd start
			  chkconfig httpd on
			  groupadd www
			  usermod -a -G www ec2-user
			  chown -R root:www /var/www
			  chmod 2775 /var/www
			  find /var/www -type d -exec sudo chmod 2775 {} +
			  find /var/www -type f -exec sudo chmod 0664 {} +
			  cd /var/www/html
			  aws s3 cp s3://amanawscom/index.php index.php
			   echo "<?php" >> /var/www/html/dbinfo.inc
			  echo "define('DB_SERVER','${aws_db_instance.default.endpoint}');define('DB_USERNAME', 'terraform_user');define('DB_PASSWORD', 'terraform_user');define('DB_DATABASE', 'terraform_user');" >> /var/www/html/dbinfo.inc
			  echo "?>" >> /var/www/html/dbinfo.inc
			HEREDOC
	  tags {
			Name = "phpapp"
	  }
	}