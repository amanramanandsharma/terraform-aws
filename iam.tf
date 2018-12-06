	
	resource "aws_iam_role" "ec2_s3_access_role" {
		  name               = "s3-role"
		  assume_role_policy = "${file("assumerolepolicy.json")}"
		}
	
	resource "aws_iam_policy_attachment" "test-attach" {
		  name       = "test-attachment"
		  roles      = ["${aws_iam_role.ec2_s3_access_role.name}"]
		  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
		}
		
	resource "aws_iam_instance_profile" "s3_access" {
		  name  = "s3_access"
		  role = "${aws_iam_role.ec2_s3_access_role.name}"
		}
