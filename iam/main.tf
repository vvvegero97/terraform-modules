# IAM user for ECR login-pull-push
resource "aws_iam_policy" "ecr_login_pull_push" {
  name        = "${var.deployment_prefix}-ECR-policy"
  description = "IAM policy for ECR login and pull-push permissions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ExampleStatement"
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = var.ecr_repository_arns
      }
    ]
  })
}

resource "aws_iam_user" "user" {
  name = var.ecr_user_name
}

resource "aws_iam_user_policy_attachment" "example_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.ecr_login_pull_push.arn
}
