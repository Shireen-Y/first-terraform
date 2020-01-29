output app_security_group_id {
  description = "This is the ID from my security group from my app"
  value = aws_security_group.app_security_group.id
}
