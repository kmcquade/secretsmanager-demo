# Overview

Creates a series of secrets in AWS Secrets Manager. Supply the values and they will be uploaded here.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| count | The number of secrets to create. | string | - | yes |
| default_tags | Billing tags used across all taggable resources. | map | - | yes |
| kms_key_id | The globally unique identifier for the KMS key. | string | - | yes |
| recovery_window_in_days | Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30. | string | `30` | no |
| secret_description | A description of the secret. Use the app name here. | string | - | yes |
| secret_names | Name of the secret. | list | - | yes |
| secret_path | Path to the secret. Use a standard prefix indicating the app and environment. Example: dev/consul | string | - | yes |
| secret_strings | Specifies text data that you want to encrypt and store in this version of the secret. | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| secret_arn | Amazon Resource Name (ARN) of the secret. |
| secret_id | Amazon Resource Name (ARN) of the secret. |
| secret_version_arn | List of the secret IDs stored in AWS Secrets Manager. |
| secret_version_id | A list of the pipe delimited combinations of secret IDs and version IDs. |