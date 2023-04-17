# Creating a Variable for region
variable "region" {
  default = "eu-west-1"
}

# Creating a Variable for instance_type
variable "instance_type" {
  type    = string
  default = "t3.small"
}

# Creating a Variable for the generic name
variable "primary_name" {
  type    = string
  default = "my_machine"
}

# Creating a Variable for the public IP
variable "public_ip" {
  type    = string
  default = "0.0.0.0/0"
}























































# variable "tag_ec2" {
#   type = set(string)
#   default = ["alpha","beta","gamma","delta"]
# }

# variable "bucket_name_list" {
#   type = set(string)
#   default = ["demo-policy-test-01","demo-policy-test-02","demo-policy-test-03","demo-policy-test-04"]
# }