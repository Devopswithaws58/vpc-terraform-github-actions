resource "aws_security_group" "dev_SG" {
  vpc_id = var.dev_vpc_id
  dynamic "ingress" {
    for_each = var.inbount_port_numbers
    content {
      protocol    = "TCP"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = title("${var.project_name}-${terraform.workspace}-Security_group-allow-ports")
  }
}