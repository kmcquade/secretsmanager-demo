# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "secrets_arns" {
  type        = "list"
  description = "The ARN of the Secrets Manager Secret"
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key."
}

variable "iam_role_prefix" {
  description = "Naming prefix of IAM resources."
}
