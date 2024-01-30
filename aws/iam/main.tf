resource "aws_iam_policy" "ecr_login_pull_push" {
  name        = "${var.deployment_prefix}-ECR-policy"
  description = "IAM policy for ECR login and pull-push permissions"
  policy      = var.ecr_policy
}

resource "aws_iam_user" "user" {
  name = var.ecr_user_name
}

resource "aws_iam_user_policy_attachment" "example_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.ecr_login_pull_push.arn
}
