# https://www.terraform.io/docs/providers/aws/r/secretsmanager_secret.html
resource "aws_secretsmanager_secret" "example" {
  count                   = "${var.count}"
  name                    = "${var.secret_path}/${element(var.secret_names, count.index)}"
  description             = "${var.secret_description}"
  kms_key_id              = "${var.kms_key_id}"
  recovery_window_in_days = "${var.recovery_window_in_days}"
  tags                    = "${merge(map("Name", element(var.secret_names, count.index)), var.default_tags)}"

  #https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_resource-based-policies.html#example_1
  # Note that you cannot use the aws_iam_policy_document data source here; that would result in a
  # circular dependency so you have to declare the policy inline here.
  /*
  There are two methods for granting EC2 instances access to AWS Secrets manager:
    (1) Granting permissions via IAM Instance Profiles
    (2) Granting permissions from the policy attached to the secret itself.
  The text below shows how to grant access to the secret itself. I've commented this out
  because we are taking approach #1 for this demo.
  */
  /*
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": {"AWS": "${var.role_arn}"},
      "Action": "secretsmanager:GetSecretValue",
      "Resource": "*",
      "Condition": {
        "ForAnyValue:StringEquals": {
          "secretsmanager:VersionStage" : "AWSCURRENT",
          "secretsmanager:Name" : "${var.secret_path}\/${element(var.secret_names,count.index)}"        }
      }
    }
  }
  POLICY
  */
}

# https://www.terraform.io/docs/providers/aws/r/secretsmanager_secret_version.html
resource "aws_secretsmanager_secret_version" "example" {
  count          = "${var.count}"
  secret_id      = "${element(aws_secretsmanager_secret.example.*.id, count.index)}"
  secret_string  = "${element(var.secret_strings, count.index)}"
  version_stages = ["one", "two", "AWSCURRENT"]
  depends_on     = ["aws_secretsmanager_secret.example"]
}
