# Security group rules for NLB traffic, Ingress and Egress

resource "aws_security_group_rule" "nlb_ingress_rules" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["10.10.0.0/16"]
  security_group_id = aws_security_group.nlb_sg.id
}

resource "aws_security_group_rule" "nlb_egress_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nlb_sg.id
}

# Security group rules for Service traffic, Ingress and Egress

resource "aws_security_group_rule" "svc_ingress_rules" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["10.10.0.0/16"]
  security_group_id = aws_security_group.service_sg.id
}

resource "aws_security_group_rule" "svc_egress_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.service_sg.id
}