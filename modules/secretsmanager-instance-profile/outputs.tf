output "role_id" {
  value       = "${aws_iam_role.sms_webinar.id}"
  description = "The stable and unique string identifying the role."
}

output "role_arn" {
  value       = "${aws_iam_role.sms_webinar.arn}"
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "role_name" {
  value       = "${aws_iam_role.sms_webinar.name}"
  description = "The name of the role."
}

output "instance_profile_arn" {
  value       = "${aws_iam_instance_profile.sms_webinar.arn}"
  description = "The ARN assigned by AWS to the instance profile."
}

output "instance_profile_id" {
  value       = "${aws_iam_instance_profile.sms_webinar.id}"
  description = "The instance profile's ID"
}

output "instance_profile_name" {
  value       = "${aws_iam_instance_profile.sms_webinar.name}"
  description = "The instance profile's name."
}
