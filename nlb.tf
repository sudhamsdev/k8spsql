resource "aws_lb" "psql_nlb" {
  name               = var.nlb_name
  internal           = true
  load_balancer_type = "network"
  subnets            = data.aws_subnets.private_subnets.ids
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.nlb_sg.id]

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = merge(
    local.common_tags,
    {
      Name = "k8sengineersnlb-ecs"
    }
  )
}

resource "aws_lb_listener" "psql_listener" {
  load_balancer_arn = aws_lb.psql_nlb.arn
  port              = "5432"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_targetgroup.arn
  }

  depends_on = [
    aws_lb.psql_nlb
  ]
}