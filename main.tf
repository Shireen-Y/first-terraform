# Set a provider
# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
}

# Create VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.app_name} - VPC"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "app_gw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.app_name} - igw"
  }
}

# Call module to create app_tier
module "app" {
  source = "./modules/app_tier"
  vpc_id = aws_vpc.app_vpc.id
  gateway_id = aws_internet_gateway.app_gw.id
  app_name = var.app_name
  db_instance-ip = module.db.db_instance-ip
  ami_id_app = var.ami_id_app
  pub_ip = module.db.pub_ip
}

# Call module to create db_tier
module "db" {
  source = "./modules/db_tier"
  vpc_id = aws_vpc.app_vpc.id
  gateway_id = aws_internet_gateway.app_gw.id
  app_security_group_id = module.app.app_security_group_id
  db_name = var.db_name
  ami_id_db = var.ami_id_db
}
