terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "WilsonSo"

    workspaces {
      name = "terraform-cloud-tier3"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# data "terraform_remote_state" "terraform-cloud-tier1" {
#   backend = "remote"
#   config = {
#     hostname     = "app.terraform.io"
#     organization = "WilsonSo"
#
#     workspaces = {
#       name = "terraform-cloud-tier1"
#     }
#   }
# }

data "terraform_remote_state" "terraform-cloud-tier2" {
  backend = "remote"
  config = {
    hostname     = "app.terraform.io"
    organization = "WilsonSo"

    workspaces = {
      name = "terraform-cloud-tier2"
    }
  }
}
