output pub_ip {
  description = "This is the ID from my security group for the db"
  value = aws_instance.db_instance.*.public_ip
}

output "db_instance-ip" {
  value = aws_instance.db_instance.private_ip
}
