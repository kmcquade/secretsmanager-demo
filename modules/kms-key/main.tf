# https://www.terraform.io/docs/providers/aws/r/kms_key.html
resource "aws_kms_key" "example" {
  description             = "${var.kms_key_description}"
  key_usage               = "${var.key_usage}"
  is_enabled              = "${var.kms_is_enabled}"
  deletion_window_in_days = 30
}

resource "random_id" "example_suffix" {
  byte_length = 4
}

# https://www.terraform.io/docs/providers/aws/d/kms_alias.html
resource "aws_kms_alias" "example" {
  name          = "alias/${var.kms_alias_name}-${random_id.example_suffix.hex}"
  target_key_id = "${aws_kms_key.example.key_id}"
}
