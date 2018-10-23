# Secretsmanager_secret
output "secret_id" {
  value       = "${aws_secretsmanager_secret.example.*.id}"
  description = "Amazon Resource Name (ARN) of the secret."
}

output "secret_arn" {
  value       = "${aws_secretsmanager_secret.example.*.arn}"
  description = "Amazon Resource Name (ARN) of the secret."
}

output "secret_version_id" {
  value       = "${aws_secretsmanager_secret_version.example.*.secret_id}"
  description = "A list of the pipe delimited combinations of secret IDs and version IDs."
}

output "secret_version_arn" {
  value       = "${aws_secretsmanager_secret_version.example.*.arn}"
  description = "List of the secret IDs stored in AWS Secrets Manager."
}
