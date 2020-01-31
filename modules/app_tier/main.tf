# Main for app_tier
# Place all that concerns the app_tier in here

# Create subnet for app
resource "aws_subnet" "app_subnet" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "${var.app_name} - subnet"
  }
}

# Create route table
resource "aws_route_table" "app_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
  tags = {
    Name = "${var.app_name} - route"
  }
}

# Route table associations
resource "aws_route_table_association" "app_assoc" {
  subnet_id = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.app_route_table.id
}

# Create security groups
resource "aws_security_group" "app_security_group" {
  tags = {
    Name = "${var.app_name} - sg"
    }
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 27017
    to_port = 27017
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Send template to sh file
data "template_file" "app_init" {
  template = "${file("./scripts/init_script.sh.tpl")}"
  vars = {
    db-ip=var.db_instance-ip
  }
}

# Launch an instance
resource "aws_instance" "app_instance" {
  ami           = var.ami_id_app
  subnet_id = aws_subnet.app_subnet.id
  vpc_security_group_ids = [aws_security_group.app_security_group.id]
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "shireen-eng-48-first-key"
  user_data = data.template_file.app_init.rendered
  tags = {
    Name = "${var.app_name} - app instance"
  }
}
