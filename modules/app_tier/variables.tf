variable "vpc_id" {
  description = "The VPC ID of which the app is launched"
}

variable "gateway_id" {
  description = "Gateway ID interpolated from original variables.tf"
}

variable "app_name" {
  description = "Name interpolated from original variables.tf file"
}

variable "ami_id_app" {
  description = "AMI ID interpolated from original variables.tf file"
}

variable "pub_ip" {
  description = "Generated ip"
}

variable "db_instance-ip" {
  description = "IP of the db instance"
}
