resource "aws_lb" "kubernetes" {
  name               = "kubernetes"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnet_id

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_lb_target_group" "kubernetes" {
  name        = "kubernetes"
  port        = 6443
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_lb_listener" "kubernetes" {
  load_balancer_arn = aws_lb.kubernetes.arn
  port              = 443
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kubernetes.arn
  }
}

output "kubernetes_public_address" {
  value = aws_lb.kubernetes.dns_name
}
