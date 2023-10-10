resource "aws_security_group" "nlb_sg" {
  name        = var.nlb_sg_name
  description = "Security Group to allow Ingress and Egress traffic on NLB"
  vpc_id      = data.aws_vpc.prod_vpc.id
}

resource "aws_security_group" "service_sg" {
  name        = var.service_sg_name
  description = "Security Group to allow Ingress and Egress traffic to ECS task"
  vpc_id      = data.aws_vpc.prod_vpc.id
}