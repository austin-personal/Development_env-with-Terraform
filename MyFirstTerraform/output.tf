output "instance_public_ip" {
  value = aws_instance.mk_ec2.public_ip
}