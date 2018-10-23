//resource "random_pet" "env" {
//  length    = 2
//  separator = "_"
//}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_iam_role" "sms_webinar" {
  name               = "${var.iam_role_prefix}-${random_id.suffix.hex}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_role_policy" "sms_webinar" {
  name   = "${var.iam_role_prefix}-${random_id.suffix.hex}"
  role   = "${aws_iam_role.sms_webinar.id}"
  policy = "${data.aws_iam_policy_document.instance_policy.json}"
}

resource "aws_iam_instance_profile" "sms_webinar" {
  name = "${var.iam_role_prefix}-${random_id.suffix.hex}-IP"
  role = "${aws_iam_role.sms_webinar.name}"
}
