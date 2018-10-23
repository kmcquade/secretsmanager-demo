output "README" {
  value = <<README
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
A private RSA key has been generated and downloaded locally. The file
permissions have been changed to 0600 so the key can be used immediately for
SSH or scp.

Run the below command to add this private key to the list maintained by
ssh-agent so you're not prompted for it when using SSH or scp to connect to
hosts with your public key.

  ${format("$ ssh-add %s", module.ssh_keypair_aws.private_key_filename)}

The public part of the key loaded into the agent ("public_key_openssh" output)
has been placed on the target system in ~/.ssh/authorized_keys.

Run the below command to connect to the secure instance:

  ${format("$ ssh -A ubuntu@%s", aws_instance.secrets_test.public_ip)}

To connect to the instance with bad secrets management:

  ${format("$ ssh -A ubuntu@%s", aws_instance.bad_bastion.public_ip)}

Browse to the /opt directory and run `ls -al`. Notice from the size of the secret files have been downloaded and
stored properly, indicating successful authorization to and retrieval of the certs in secrets manager.

README
}

output "secret_ids" {
  value       = "${module.secrets_manager_secret.secret_id}"
  description = "List of the secret IDs stored in AWS Secrets Manager."
}

output "ssh_key_name" {
  value       = "${module.ssh_keypair_aws.name}"
  description = "SSH Keypair name used for connecting to the instance"
}

output "subnet_public_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "vpc_id" {
  value       = "${aws_vpc.main.id}"
  description = "The ID of the VPC"
}

output "vpc_cidr" {
  value       = "${aws_vpc.main.cidr_block}"
  description = "The CIDR block of the VPC"
}

output "bastion_ips_public" {
  value       = ["${aws_instance.secrets_test.*.public_ip}"]
  description = "The public IP address assigned to the instance."
}

output "bad_bastion_ips_public" {
  value       = ["${aws_instance.bad_bastion.*.public_ip}"]
  description = "The public IP address assigned to the instance."
}

//output "bad_bastion_userdata" {
//  value = "${data.template_file.bad_bastion_user_data.rendered}"
//}


//output "good_bastion_userdata" {
//  value = "${data.template_file.good_bastion_user_data.rendered}"
//}


//output "secret_arns" {
//  value = "${module.secrets_manager_secret.secret_arn}"
//}

