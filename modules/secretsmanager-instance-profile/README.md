# Overview

Creates an instance profile with permissions to access only the secrets that are supplied through the module inputs.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_role_prefix | Naming prefix of IAM resources. | string | - | yes |
| kms_key_arn | The ARN of the KMS key. | string | - | yes |
| secrets_arns | The ARN of the Secrets Manager Secret | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance_profile_arn | The ARN assigned by AWS to the instance profile. |
| instance_profile_id | The instance profile's ID |
| instance_profile_name | The instance profile's name. |
| role_arn | The Amazon Resource Name (ARN) specifying the role. |
| role_id | The stable and unique string identifying the role. |
| role_name | The name of the role. |
