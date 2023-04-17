provider "aws" {
  region = var.region 
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "public-terraform-state"
    dynamodb_table = "public-terraform-state"
    key            = "public-terraform-state/terraform.tfstate"
    region         = "eu-west-1"
  }
}

#Get AMI ID
data "aws_ami" "aws_linux_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

# Create Key Pair
resource "aws_key_pair" "my_machine_kp" {
  key_name   = "${var.primary_name}-standard-keypair"
  public_key = file("./id_rsa.pub")
  tags = {
    Name = "${var.primary_name}-standard-keypair",
  }
}

# Create Security Group
resource "aws_security_group" "my_machine_sg" {
  name = "${var.primary_name} security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_ip]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Create EC2
resource "aws_instance" "my_machine" {

  ami           = data.aws_ami.aws_linux_latest.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.my_machine_kp.key_name
  vpc_security_group_ids = [aws_security_group.my_machine_sg.id]
  tags = {
    Name = var.primary_name
  }
}









































# resource "aws_instance" "my-machine" {
#   # Creates four identical aws ec2 instances
#   count = 4

#   # All four instances will have the same ami and instance_type
#   ami = data.aws_ami.ubuntu_latest.id
#   instance_type = var.instance_type
#   tags = {
#     # The count.index allows you to launch a resource 
#     # starting with the distinct index number 0 and corresponding to this instance.
#     Name = "my-machine-${count.index}"
#   }
# }

# resource "aws_instance" "my-machine" {
#   # Creates four identical aws ec2 instances
#   count = length(var.tag_ec2)

#   # All four instances will have the same ami and instance_type
#   ami = data.aws_ami.ubuntu_latest.id
#   instance_type = var.instance_type
#   tags = {
#     # The count.index allows you to launch a resource 
#     # starting with the distinct index number 0 and corresponding to this instance.
#     Name = "my-machine-${count.index}"
#   }
# }

# resource "aws_instance" "my-machine" {
#   # Creates four aws ec2 instances with different names

#   # All four instances will have the same ami and instance_type
#   ami = data.aws_ami.ubuntu_latest.id
#   instance_type = var.instance_type
#   for_each  = var.tag_ec2
#     tags = {
#         Name = each.value
#     }
# }

# resource "aws_s3_bucket" "s3_buckets" {
#    for_each = var.bucket_name_list
#    bucket = each.value
# }

# data "aws_iam_policy_document" "s3_allow_access" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:ListBucket",
#       "s3:GetObject",
#       "s3:PutObject"
#     ]
#     resources = [
#       for bucket_name in var.bucket_name_list:
#         "arn:aws:s3:::${bucket_name}/*"
#     ]
#   }
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:ListAllMyBuckets"
#     ]
#     resources = [
#       "*"
#     ]
#   }
# }

# resource "aws_iam_policy" "s3_allow_access" {
#   name = "s3_allow_access"
#   description = "Allows access to S3 buckets"
#   policy = data.aws_iam_policy_document.s3_allow_access.json
# }