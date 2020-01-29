resource "aws_security_group" "db_sg" {
  name = var.name
  description = "Allow traffic from app"
  vpc_id = var.vpc_id

  ingress {
    from_port = 27017
    to_port = 27017
    protocol = "TCP"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name} - db_sg"
  }
}
