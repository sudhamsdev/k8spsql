resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = data.aws_ecs_cluster.ecs_cluster_ds.cluster_name
  task_definition = aws_ecs_task_definition.servce_task.arn
  desired_count   = 1
  network_configuration {
    subnets         = data.aws_subnets.private_subnets.ids
    security_groups = [aws_security_group.service_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cw_policy_attach,
    aws_iam_role_policy_attachment.ecr_policy_attach,
    aws_iam_role_policy_attachment.ssm_policy_attach,
    aws_lb.psql_nlb,
    aws_lb_target_group.nlb_targetgroup,
    aws_ecs_task_definition.servce_task
  ]

  load_balancer {
    target_group_arn = aws_lb_target_group.nlb_targetgroup.arn
    container_name   = var.container_name
    container_port   = 5432
  }

  wait_for_steady_state = true
}