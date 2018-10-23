data "template_file" "bad_user_data" {
  template = "${file("${path.module}/templates/bad-bastion.sh.tpl")}"

  vars = {
    name            = "${var.name}"
    aws_region      = "${var.aws_region}"
    provider        = "${var.provider}"
    local_ip_url    = "${var.local_ip_url}"
    ca_crt          = "${module.root_tls_self_signed_ca.ca_cert_pem}"
    leaf_crt        = "${module.leaf_tls_self_signed_cert.leaf_cert_pem}"
    leaf_key        = "${module.leaf_tls_self_signed_cert.leaf_private_key_pem}"
    consul_encrypt  = "${random_id.consul_encrypt.b64_std}"
    consul_override = "${var.consul_client_config_override != "" ? true : false}"
    consul_config   = "${var.consul_client_config_override}"
  }
}

data "template_file" "good_bastion_user_data" {
  template = "${file("${path.module}/templates/refactored-bastion.sh.tpl")}"

  vars = {
    aws_region = "${var.aws_region}"
    ca_crt     = "${element(module.secrets_manager_secret.secret_id, 0)}"
    leaf_crt   = "${element(module.secrets_manager_secret.secret_id, 1)}"
    leaf_key   = "${element(module.secrets_manager_secret.secret_id, 2)}"
  }
}
