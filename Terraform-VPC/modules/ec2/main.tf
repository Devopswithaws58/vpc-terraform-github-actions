resource "aws_instance" "dev_docker_server" {

  count                       = length(var.dev_public_subnets_ids)
  ami                         = data.aws_ami.amazon-2.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [var.dev_SG_id]
  key_name                    = "lwplabskey"
  associate_public_ip_address = true
  subnet_id                   = var.dev_public_subnets_ids[count.index]
  availability_zone           = data.aws_availability_zones.available.names[count.index]
  user_data                   = local.name
  tags = {
    "Name" = title("${var.project_name}-${terraform.workspace}-docker-engine-${count.index + 1}")
  }
}
locals {
  name = templatefile("./install-docker.tpl", {})
}