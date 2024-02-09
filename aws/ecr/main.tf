resource "aws_ecr_repository" "template" {
  name                 = "${var.deployment_prefix}/${var.ecr_name}"
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = var.kms_key_id
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    "Name"        = "${var.deployment_prefix}/${var.ecr_name}"
    "Type"        = "Elastic Container Registry"
    "Description" = "Registry for deployment related to ${var.deployment_prefix}"
  }
}

data "aws_iam_policy_document" "ecr_policy" {
  count = var.ecr_user_arn != "none" ? 1 : 0
  statement {
    sid    = "AllowPullAndPush"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.ecr_user_arn]
    }

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:DescribeImages",
    ]
  }
}

resource "aws_ecr_repository" "template_cache" {
  count = var.create_ecr_cache_repository ? 1 : 0

  name                 = "${var.deployment_prefix}/${var.ecr_name}/cache"
  image_tag_mutability = "MUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = var.kms_key_id
  }
  tags = {
    "Name"        = "${var.deployment_prefix}/${var.ecr_name}/cache"
    "Type"        = "Elastic Container Registry"
    "Description" = "Registry for deployment related to ${var.deployment_prefix}"
  }
}

resource "aws_ecr_lifecycle_policy" "template_cache_policy" {
  count = var.create_ecr_cache_repository ? 1 : 0

  repository = aws_ecr_repository.template_cache[0].name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than ${var.number_of_days_to_keep_cache_images} days",
            "selection": {
                "tagStatus": "any",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": ${var.number_of_days_to_keep_cache_images}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
