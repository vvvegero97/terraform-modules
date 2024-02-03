data "aws_caller_identity" "account" {}

resource "aws_kms_key" "kms_deployment_key" {
  description              = "AWS KMS key used to encrypt AWS resources."
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  # The following snippet shows the policy statement that gives an example AWS account full access to a KMS key. This policy statement lets the account use IAM policies, along with key policies, to control access to the KMS key.
  policy = <<EOT
{
    "Version": "2012-10-17",
    "Id": "${var.deployment_prefix}-${var.name}",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.account.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
EOT
}

resource "aws_kms_alias" "kms_deployment_key" {
  name          = "alias/${var.deployment_prefix}-${var.name}"
  target_key_id = aws_kms_key.kms_deployment_key.key_id
}

resource "aws_iam_service_linked_role" "autoscaling" {
  count            = var.aws_iam_service_linked_role_autoscaling ? 1 : 0
  aws_service_name = "autoscaling.amazonaws.com"
}
