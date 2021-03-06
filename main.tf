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

# East
locals {
  east_certificate_arn = var.active_internal_api_certificate == "2" ? aws_iam_server_certificate.east_cert_2.arn: aws_iam_server_certificate.east_cert.arn
}

resource "aws_iam_server_certificate" "east_cert" {
  name             = "east_internal_api_cert"
  certificate_body = var.internal_certificate
  private_key      = var.private_key
}

resource "aws_iam_server_certificate" "east_cert_2" {
  name             = "east_internal_api_cert_2"
  certificate_body = var.internal_certificate_2
  private_key      = var.private_key_2
}

# West
locals {
  west_certificate_arn = var.active_internal_api_certificate == "2" ? aws_iam_server_certificate.west_cert_2.arn: aws_iam_server_certificate.west_cert.arn
}

resource "aws_iam_server_certificate" "west_cert" {
  name             = "west_internal_api_cert"
  certificate_body = var.internal_certificate
  private_key      = var.private_key
}

resource "aws_iam_server_certificate" "west_cert_2" {
  name             = "west_internal_api_cert_2"
  certificate_body = var.internal_certificate_2
  private_key      = var.private_key_2
}
