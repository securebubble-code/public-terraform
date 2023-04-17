output "ami_id" {
  value = data.aws_ami.aws_linux_latest.id
}

output "ami_name" {
  value = data.aws_ami.aws_linux_latest.name
}

output "ec2_id" {
  value = aws_instance.my_machine.id
}

output "ec2_private_ip" {
  value = aws_instance.my_machine.private_ip
}

output "ec2_public_ip" {
  value = aws_instance.my_machine.public_ip
}
