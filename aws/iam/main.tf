resource "aws_iam_policy" "generated_policy" {
  for_each = var.policy_map

  name        = "${var.deployment_prefix}-${each.value.name}"
  description = each.value.description
  policy      = each.value.policy #tfsec:ignore:aws-iam-no-policy-wildcards
}

resource "aws_iam_user_policy_attachment" "attachment" {
  for_each   = var.policy_map
  user       = var.user_name
  policy_arn = aws_iam_policy.generated_policy[each.key].arn
}

resource "aws_iam_role" "ecr_access_role" {
  count = var.create_ec2_role ? 1 : 0
  name  = "${var.deployment_prefix}-ecr-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

locals {
  enabled_policies = var.create_ec2_role ? var.policy_map : {}
}

resource "aws_iam_role_policy_attachment" "ec2_role_attachment" {
  for_each   = local.enabled_policies
  role       = aws_iam_role.ecr_access_role[0].name
  policy_arn = aws_iam_policy.generated_policy[each.key].arn
}

resource "aws_iam_user" "this_user" {
  count = var.create_user ? 1 : 0
  name  = var.user_name
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = var.user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_access_key" "this_user_key" {
  count = var.create_user ? 1 : 0
  user  = aws_iam_user.this_user[0].name
}

resource "aws_ssm_parameter" "this_user_access_key" {
  count       = var.create_user ? 1 : 0
  name        = "/${var.deployment_prefix}/${var.user_name}/access_key"
  description = "S3 sync user's AWS Access Key for deployment: ${var.deployment_prefix}"
  tier        = "Standard"
  type        = "SecureString"
  key_id      = var.kms_key_id
  value       = aws_iam_access_key.this_user_key[0].id
}

resource "aws_ssm_parameter" "this_user_secret_key" {
  count       = var.create_user ? 1 : 0
  name        = "/${var.deployment_prefix}/${var.user_name}/secret_key"
  description = "S3 sync user's AWS Secret Key for deployment: ${var.deployment_prefix}"
  tier        = "Standard"
  type        = "SecureString"
  key_id      = var.kms_key_id
  value       = aws_iam_access_key.this_user_key[0].secret
}
