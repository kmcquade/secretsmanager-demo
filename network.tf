data "aws_availability_zones" "main" {}

data "aws_vpc_endpoint_service" "kms" {
  service = "kms"
}

data "aws_vpc_endpoint_service" "secretsmanager" {
  service = "secretsmanager"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags                 = "${merge(map("Name", var.name), var.default_tags)}"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.main.id}"
  tags   = "${merge(map("Name", var.name), var.default_tags)}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}" # Use the route table created with the VPC
  destination_cidr_block = "0.0.0.0/0"                           # Permitted IP range for outbound internet destinations
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "public" {
  count                   = "${length(var.subnet_cidrs_public)}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(var.subnet_cidrs_public, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.main.names, count.index)}"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "bastion" {
  name_prefix = "${var.name}-bastion-"
  description = "Security Group for ${var.name} Bastion hosts"
  vpc_id      = "${aws_vpc.main.id}"
  tags        = "${merge(map("Name", format("%s-bastion", var.name)), var.default_tags)}"
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = "${var.allowed_inbound_cidrs}"
}

resource "aws_security_group_rule" "ingress_vpc_internal" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["${var.vpc_cidr}"]
}

resource "aws_security_group_rule" "egress_public" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = "${var.allowed_outbound_cidrs}"
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "${data.aws_vpc_endpoint_service.kms.service_name}"
  vpc_endpoint_type = "Interface"
  subnet_ids        = ["${aws_subnet.public.*.id}"]

  security_group_ids = [
    "${aws_security_group.bastion.id}",
  ]

  auto_accept         = true
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "secrets_mgr" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "${data.aws_vpc_endpoint_service.secretsmanager.service_name}"
  vpc_endpoint_type = "Interface"
  subnet_ids        = ["${aws_subnet.public.*.id}"]

  security_group_ids = [
    "${aws_security_group.bastion.id}",
  ]

  auto_accept         = true
  private_dns_enabled = true
}
