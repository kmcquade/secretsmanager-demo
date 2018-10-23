provider "aws" {
  version = ">= 1.40.0"
  region  = "${var.aws_region}"
}

module "kms_key" {
  source                  = "modules/kms-key"
  kms_alias_name          = "${var.kms_alias_name}"
  kms_key_description     = "${var.kms_key_description}"
  kms_is_enabled          = true
  deletion_window_in_days = "7"
}

module "secrets_manager_secret" {
  source             = "modules/secretsmanager-secret"
  count              = "3"
  secret_description = "Test secrets"
  secret_path        = "${var.secret_path}"

  secret_names = [
    "${module.leaf_tls_self_signed_cert.ca_cert_filename}",
    "${module.leaf_tls_self_signed_cert.leaf_cert_filename}",
    "${module.leaf_tls_self_signed_cert.leaf_private_key_filename}",
  ]

  secret_strings = [
    "${module.root_tls_self_signed_ca.ca_cert_pem}",
    "${module.leaf_tls_self_signed_cert.leaf_cert_pem}",
    "${module.leaf_tls_self_signed_cert.leaf_private_key_pem}",
  ]

  kms_key_id              = "${module.kms_key.kms_key_id}"
  default_tags            = "${var.default_tags}"
  recovery_window_in_days = "7"
}

module "secrets_manager_ip" {
  source          = "modules/secretsmanager-instance-profile"
  secrets_arns    = "${module.secrets_manager_secret.secret_version_arn}"
  kms_key_arn     = "${module.kms_key.kms_arn}"
  iam_role_prefix = "secretsmgr-webinar"
}
