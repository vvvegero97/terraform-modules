resource "aws_iam_policy" "generated_policy" {
  for_each = var.policy_map

  name        = "${var.deployment_prefix}-${each.value.name}"
  description = each.value.description
  policy      = each.value.policy
}

resource "aws_iam_user" "user" {
  name = var.user_name
}

resource "aws_iam_user_policy_attachment" "attachment" {
  for_each = var.policy_map

  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.generated_policy[each.key].arn
}
