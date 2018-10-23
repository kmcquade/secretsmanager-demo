# terraform-aws-secretsmanager-example

Demo of secrets manager in userdata. 

# Overview

This is the second technical example in [my webinar on Securing Cloud Deployments at the Enterprise Level](https://www.synopsys.com/blogs/software-security/secure-cloud-deployments-webinar/). The other example (AWS CentOS golden images with Packer, Ansible, and Vagrant) will not be available for public viewing.

### Structure
```
.
├── LICENSE
├── README.md
├── cert.tf
├── instance.tf
├── main.tf
├── modules
│   ├── kms-key
│   ├── secretsmanager-instance-profile
│   └── secretsmanager-secret
├── network.tf
├── outputs.tf
├── templates
│   ├── bad-bastion.sh.tpl
│   └── refactored-bastion.sh.tpl
├── terraform.tfvars.example
├── userdata.tf
└── variables.tf
```

The files in the root directory and the resources they create are listed below:

* cert.tf
  * Generate self-signed certificates for storage in secrets manager.
* instances.tf
  * Looks up the most recent Ubuntu 16.04 AMI in the specified region
  * Creates two EC2 instances using that AMI:
    * Secure example: One with userdata and an IAM role attached, granting access to Secrets Manager
    * Insecure example: One where the certificate is passed in via userdata.
* main.tf
  * Uses `kms-key` module to creates a KMS key to encrypt the secrets in Secrets Manager
  * Uses the `secretsmanager-secret` module to upload the certificates to AWS Secrets Manager, encrypted with the KMS key.
  * Uses the `secretsmanager-instance-profile` module to create an IAM role, policy, and instance profile. 
    * **The policy permissions enforce least-privilege access by:**
      * **limiting usage of the AWS API to the specific API calls needed, and**
      * **limiting resource access only to the three Secrets and the KMS key specified.**
* network.tf
  * Creates a non-default VPC with a public subnet.
  * Creates an internet gateway 
  * Creates security groups that permit all traffic _within_ the VPC, SSH access only from allowed IPs, all outbound traffic _from_ the VPC.
  * **Creates VPC PrivateLink Endpoints so that API calls to AWS Secrets Manager and AWS KMS never leave the datacenter.**
* userdata.tf
  * Builds the userdata file from `refactored-bastion.sh.tpl` and supplies the file with resources created in Terraform.

#### Vault guides containing insecure templates

Disclaimer: the authors wrote this code as a demo environment, not for production purposes. This shown for POC purposes, not to shame them.

See links below:

* [Main module](https://github.com/hashicorp/vault-guides/tree/340b5d107a459c49d0d9ac63eb4d23376a15a096)

* [Provisioning Modules](https://github.com/hashicorp/vault-guides/tree/340b5d107a459c49d0d9ac63eb4d23376a15a096/operations/provision-vault/best-practices/terraform-aws)

* [Template Files](https://github.com/hashicorp/vault-guides/tree/340b5d107a459c49d0d9ac63eb4d23376a15a096/operations/provision-vault/templates)
  * The one we are using for the insecure case example is titled [best-practices-bastion-systemd.sh.tpl](https://github.com/hashicorp/vault-guides/blob/340b5d107a459c49d0d9ac63eb4d23376a15a096/operations/provision-vault/templates/best-practices-bastion-systemd.sh.tpl).


# Related

https://www.terraform.io/docs/providers/aws/r/secretsmanager_secret.html

https://www.terraform.io/docs/providers/aws/r/secretsmanager_secret_version.html

# More security enhancements

More security enhancements, depending on your use case:

* Secrets Manager Policy refinements to restrict access to the secret from:
  * A specific VPC Privatelink endpoint only.
  * A specific VPC only.
  * A specific IP Range only.

Examples for the above are in the links [here](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotation-network-rqmts.html#vpc-endpoint-policies). 