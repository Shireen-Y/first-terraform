resource "aws_security_group" "db_sg" {
  name = var.db_name
  description = "Allow traffic from app"
  vpc_id = var.vpc_id

  ingress {
    from_port = 27017
    to_port = 27017
    protocol = "TCP"
    security_groups = ["${var.app_security_group_id}"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    security_groups = ["${var.app_security_group_id}"]
  }

  tags = {
    Name = "${var.db_name} - db_sg"
  }
}

# Create private subnet
resource "aws_subnet" "priv_subnet" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "${var.db_name} - private subnet"
  }
}

# Launch an instance
resource "aws_instance" "db_instance" {
  ami           = var.ami_id_db
  subnet_id = aws_subnet.priv_subnet.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "shireen-eng-48-first-key"
  tags = {
    Name = "${var.db_name} - db instance"
  }
}
