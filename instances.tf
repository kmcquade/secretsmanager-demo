# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE TEST INSTANCE
# ---------------------------------------------------------------------------------------------------------------------
# Lookup Ubuntu Xenial AMI in the region
data "aws_ami" "ubuntu" {
  most_recent = "true"
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create SSH keypair for access to test instance
module "ssh_keypair_aws" {
  source = "github.com/hashicorp-modules/ssh-keypair-aws"
  name   = "${var.name}"
}

# Instance to test AWS Secrets Manager access
resource "aws_instance" "secrets_test" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  user_data              = "${data.template_file.good_bastion_user_data.rendered}"
  iam_instance_profile   = "${module.secrets_manager_ip.instance_profile_id}"
  subnet_id              = "${aws_subnet.public.id}"
  key_name               = "${module.ssh_keypair_aws.name}"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  tags                   = "${merge(map("Name", format("%s-good", var.name)), var.default_tags)}"
}

resource "aws_instance" "bad_bastion" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  # Insecure Userdata file; certificates passed in cleartext
  user_data = "${data.template_file.bad_user_data.rendered}"

  # No instance profile used
  #iam_instance_profile = "${module.secrets_manager_ip.instance_profile_id}"

  subnet_id              = "${aws_subnet.public.id}"
  key_name               = "${module.ssh_keypair_aws.name}"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  tags                   = "${merge(map("Name", format("%s-bad", var.name)), var.default_tags)}"
}
