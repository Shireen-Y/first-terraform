variable "vpc_id" {
  description = "The VPC ID of which the app is launched"
}

variable "app_security_group_id" {
  description = "security group from app"
}

variable "name" {
  description = "Name interpolated from original variables.tf file"
}
