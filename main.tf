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

locals {
  certificate_arn = var.active_internal_api_certificate == "2" ? aws_iam_server_certificate.cert_2.arn: aws_iam_server_certificate.cert.arn
}

resource "aws_iam_server_certificate" "cert" {
  name             = "internal_api_cert"
  certificate_body = var.internal_certificate
  private_key      = var.private_key
}

resource "aws_iam_server_certificate" "cert_2" {
  name             = "internal_api_cert_2"
  certificate_body = var.internal_certificate_2
  private_key      = var.private_key_2
}
