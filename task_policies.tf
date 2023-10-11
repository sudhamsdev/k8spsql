resource "aws_iam_policy" "cloudwatch" {
  name        = var.cw_policy_name
  path        = "/"
  description = "CloudWatch to fetch logs of K8SEngineers"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        "Resource" : [
          "arn:aws:logs:*:*:*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "ssm" {
  name        = var.ssm_policy_name
  path        = "/"
  description = "Permissions to fetch parameters of K8SEngineers"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:DescribeParameters"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameters"
        ],
        "Resource" : "arn:aws:ssm:us-east-1:438894829072:parameter/*"
      }
    ]
  })
}