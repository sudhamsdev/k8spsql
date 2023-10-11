resource "aws_ecs_task_definition" "servce_task" {
  family             = var.task_name
  cpu                = "150"
  memory             = "300"
  execution_role_arn = aws_iam_role.task_role.arn
  task_role_arn      = aws_iam_role.task_role.arn
  network_mode       = "awsvpc"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  requires_compatibilities = [
    "EC2"
  ]

  container_definitions = jsonencode([
    {
      "name" : "k8spsql",
      "image" : "438894829072.dkr.ecr.us-east-1.amazonaws.com/k8sengineerspsql:1.1.0",
      "portMappings" : [
        {
          "name" : "k8spsql-5432-tcp",
          "containerPort" : 5432,
          "hostPort" : 5432,
          "protocol" : "tcp",
          "appProtocol" : "http"
        }
      ],
      "essential" : true,
      "secrets" : [
        {
          "name" : "POSTGRES_DB",
          "valueFrom" : "/k8sengineers/db_name"
        },
        {
          "name" : "POSTGRES_PASSWORD",
          "valueFrom" : "/k8sengineers/db_password"
        },
        {
          "name" : "POSTGRES_USER",
          "valueFrom" : "/k8sengineers/db_username"
        }
      ],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/k8sengineerspsql",
          "awslogs-region" : "us-east-1",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}