
## Application Load Balancer creation ##

resource "aws_lb" "dev_application_load_balancer" {
  name               = title("${var.project_name}-${terraform.workspace}-ALB")
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.dev_SG_id]
  subnets            = var.dev_public_subnets_ids
}

##   Listener   ##

resource "aws_lb_listener" "lisener" {
  load_balancer_arn = aws_lb.dev_application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}

##  Target Group for ALB  ###
resource "aws_lb_target_group" "TG" {
  name     = title("${var.project_name}-${terraform.workspace}-TG")
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.dev_vpc_id
}

#####       Target group attachment with instances    ######

resource "aws_lb_target_group_attachment" "TG-attachemt" {
  count            = length(var.docker_instances_ids)
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = var.docker_instances_ids[count.index]
  port             = "80"
}