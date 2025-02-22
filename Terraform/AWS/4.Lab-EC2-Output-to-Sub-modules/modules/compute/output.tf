output "instance_ip_addr_public" {
  value = aws_instance.demo-instance.public_ip
}

output "instance_ip_addr_private" {
  value = aws_instance.demo-instance.private_ip
}