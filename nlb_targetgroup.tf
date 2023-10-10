resource "aws_lb_target_group" "nlb_targetgroup" {
  name            = var.nlb_targetgroup_name
  port            = 5432
  protocol        = "TCP"
  target_type     = "ip"
  ip_address_type = "ipv4"
  vpc_id          = data.aws_vpc.ecs_vpc.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    protocol            = "TCP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}