/*
variable "ssh_key_name" { }
variable "security_group_id" { }
variable "subnet_id" { }
variable "instance_name" { }
*/

# ---------------------------------------------------------------------------------------------------------------------
# Basic
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  default = "us-west-1"
}

variable "default_tags" {
  type        = "map"
  description = "Billing tags used across all taggable resources."
}

variable "name" {
  description = "Base name for a few resources, used from the HashiCorp TLS module."
  default     = "kmcquade"
}

variable "secret_path" {
  description = "Path to the secret. Use a standard prefix indicating the app and environment. Example: dev/consul"
  default     = "dev/consul"
}

variable "kms_alias_name" {
  description = "The display name of the alias. This module already has the required prefix 'alias/', so just provide the desired alias name."
  default     = "kmcquade"
}

variable "kms_key_description" {
  description = "The description of the key as viewed in AWS console."
  default     = "Testing secretsmanager storage of certs."
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the KMS key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
  default     = 7
}

# ---------------------------------------------------------------------------------------------------------------------
# Networking
# ---------------------------------------------------------------------------------------------------------------------

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "allowed_inbound_cidrs" {
  description = "List of CIDR blocks permitted for inbound traffic."
  default     = ["0.0.0.0/0"]
  type        = "list"
}

variable "allowed_outbound_cidrs" {
  description = "List of CIDR blocks permitted for inbound traffic."
  default     = ["0.0.0.0/0"]
  type        = "list"
}

variable "subnet_cidrs_public" {
  default = ["10.0.1.0/24"]
  type    = "list"
}

# ---------------------------------------------------------------------------------------------------------------------
# Certificate module variables
# github.com/hashicorp-modules/tls-self-signed-cert
# ---------------------------------------------------------------------------------------------------------------------

variable "provider" {
  default     = "aws"
  description = "Not used in demo itself; just required by tls-self-signed-cert module."
}

variable "consul_server_config_override" {
  default     = ""
  description = "Not used in demo itself; just required by tls-self-signed-cert module."
}

variable "consul_client_config_override" {
  default     = ""
  description = "Not used in demo itself; just required by tls-self-signed-cert module."
}

variable "common_name" {
  default     = "example.com"
  description = "Not used in demo itself; just required by tls-self-signed-cert module."
}

variable "organization_name" {
  default     = "Example Inc."
  description = "Not used in demo itself; just required by tls-self-signed-cert module."
}

variable "local_ip_url" {
  default     = "http://169.254.169.254/latest/meta-data/local-ipv4"
  description = "Not used in demo itself; just required by tls-self-signed-cert module."
}

variable "download_certs" {
  default     = false
  description = "Not used in demo itself; just required by tls-self-signed-cert module."
}
