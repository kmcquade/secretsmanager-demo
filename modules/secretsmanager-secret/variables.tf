# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "count" {
  description = "The number of secrets to create."
}

variable "default_tags" {
  type        = "map"
  description = "Billing tags used across all taggable resources."
}

variable "kms_key_id" {
  description = "The globally unique identifier for the KMS key."
}

variable "secret_path" {
  description = "Path to the secret. Use a standard prefix indicating the app and environment. Example: dev/consul"
}

variable "secret_names" {
  type        = "list"
  description = "Name of the secret."
}

variable "secret_strings" {
  type        = "list"
  description = "Specifies text data that you want to encrypt and store in this version of the secret."
}

variable "secret_description" {
  description = "A description of the secret. Use the app name here."
}

//variable "role_arn" {
//  description = "role with access to the secret. Use this for declaring the policy inline."
//}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "recovery_window_in_days" {
  default     = 30
  description = "Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30."
}
