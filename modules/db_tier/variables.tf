variable "vpc_id" {
  description = "The VPC ID of which the app is launched"
}

variable "app_security_group_id" {
  description = "security group from app"
}

variable "db_name" {
  description = "Name interpolated from original variables.tf file"
}

variable "ami_id_db" {
  description = "DB AMI ID interpolated from original variables.tf file"
}

variable "gateway_id" {
  description = "IGW to interpolate the security group"
}
