# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "kms_key_description" {
  description = "The description of the key as viewed in AWS console."
}

variable "kms_is_enabled" {
  description = "Specifies whether the KMS key is enabled. Defaults to true."
}

variable "kms_alias_name" {
  description = "The display name of the alias. This module already has the required prefix 'alias/', so just provide the desired alias name."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "deletion_window_in_days" {
  description = "Duration in days after which the KMS key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
  default     = 30
}

variable "key_usage" {
  description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported."
  default     = "ENCRYPT_DECRYPT"
}
