output "kms_arn" {
  value       = "${aws_kms_key.example.arn}"
  description = "The Amazon Resource Name (ARN) of the key."
}

output "kms_key_id" {
  value       = "${aws_kms_key.example.key_id}"
  description = "The globally unique identifier for the key."
}

output "key_alias_arn" {
  value       = "${aws_kms_alias.example.arn}"
  description = "The Amazon Resource Name (ARN) of the key alias."
}
