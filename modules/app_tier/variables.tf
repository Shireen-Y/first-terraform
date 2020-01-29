variable "vpc_id" {
  description = "The VPC ID of which the app is launched"
}

variable "gateway_id" {
  description = "Gateway ID interpolated from original variables.tf"
}

variable "name" {
  description = "Name interpolated from original variables.tf file"
}

variable "ami_id" {
  description = "AMI ID interpolated from original variables.tf file"
}
