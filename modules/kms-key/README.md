# Overview

Creates a KMS key and alias.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| deletion_window_in_days | Duration in days after which the KMS key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. | string | `30` | no |
| key_usage | Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported. | string | `ENCRYPT_DECRYPT` | no |
| kms_alias_name | The display name of the alias. This module already has the required prefix 'alias/', so just provide the desired alias name. | string | - | yes |
| kms_is_enabled | Specifies whether the KMS key is enabled. Defaults to true. | string | - | yes |
| kms_key_description | The description of the key as viewed in AWS console. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| key_alias_arn | The Amazon Resource Name (ARN) of the key alias. |
| kms_arn | The Amazon Resource Name (ARN) of the key. |
| kms_key_id | The globally unique identifier for the key. |