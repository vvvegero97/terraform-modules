resource "aws_iam_policy" "generated_policy" {
  for_each = var.policy_map

  name        = "${var.deployment_prefix}-${each.value.name}"
  description = each.value.description
  policy      = each.value.policy #tfsec:ignore:aws-iam-no-policy-wildcards
}

resource "aws_iam_user_policy_attachment" "attachment" {
  for_each   = var.policy_map
  user       = var.sync_user_name
  policy_arn = aws_iam_policy.generated_policy[each.key].arn
}

resource "aws_iam_user" "sync_user" {
  count = var.create_sync_user ? 1 : 0
  name  = var.sync_user_name
}

resource "aws_iam_access_key" "sync_user_key" {
  count = var.create_sync_user ? 1 : 0
  user  = aws_iam_user.sync_user[0].name
}

resource "aws_ssm_parameter" "sync_user_access_key" {
  count       = var.create_sync_user ? 1 : 0
  name        = "/${var.deployment_prefix}/s3_user/access_key"
  description = "S3 sync user's AWS Access Key for deployment: ${var.deployment_prefix}"
  tier        = "Standard"
  type        = "SecureString"
  key_id      = var.kms_key_id
  value       = aws_iam_access_key.sync_user_key[0].id
}

resource "aws_ssm_parameter" "sync_user_secret_key" {
  count       = var.create_sync_user ? 1 : 0
  name        = "/${var.deployment_prefix}/s3_user/secret_key"
  description = "S3 sync user's AWS Secret Key for deployment: ${var.deployment_prefix}"
  tier        = "Standard"
  type        = "SecureString"
  key_id      = var.kms_key_id
  value       = aws_iam_access_key.sync_user_key[0].secret
}
