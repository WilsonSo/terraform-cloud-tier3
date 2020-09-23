resource "aws_security_group" "infra_internal" {
  name        = "infra-internal"
  description = "infra-internal security group"
  vpc_id      = data.terraform_remote_state.terraform-cloud-tier2.outputs.vpc_infra_id

  tags = {
    Name = "infra-internal"
  }
}

resource "aws_security_group_rule" "ssh-access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [data.terraform_remote_state.terraform-cloud-tier2.outputs.infra_internal_subnet.cidr_block]
  security_group_id = aws_security_group.infra_internal.id
}
