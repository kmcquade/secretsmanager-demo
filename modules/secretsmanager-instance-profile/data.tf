data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "instance_policy" {
  statement {
    sid       = "SecretsManagerAccess"
    effect    = "Allow"
    resources = ["${var.secrets_arns}"]

    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
    ]
  }

  statement {
    sid       = "KMSKeyforSecretsManagerModule"
    resources = ["${var.kms_key_arn}"]
    effect    = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
    ]
  }
}
