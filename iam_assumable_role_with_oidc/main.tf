# Based on https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-assumable-role-with-oidc

locals {
  aws_account_id = data.aws_caller_identity.this.account_id
  aws_partition  = data.aws_partition.this.partition

  # clean URLs of https:// prefix
  urls = [for url in var.provider_urls : replace(url, "https://", "")]
}

data "aws_partition" "this" {}

data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "assume_role_with_oidc" {

  dynamic "statement" {
    for_each = local.urls

    content {
      effect = "Allow"

      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type = "Federated"

        identifiers = ["arn:${local.aws_partition}:iam::${local.aws_account_id}:oidc-provider/${statement.value}"]
      }

      dynamic "condition" {
        for_each = length(var.oidc_fully_qualified_subjects) > 0 ? local.urls : []

        content {
          test     = "StringEquals"
          variable = "${statement.value}:sub"
          values   = var.oidc_fully_qualified_subjects
        }
      }

      dynamic "condition" {
        for_each = length(var.oidc_subjects_with_wildcards) > 0 ? local.urls : []

        content {
          test     = "StringLike"
          variable = "${statement.value}:sub"
          values   = var.oidc_subjects_with_wildcards
        }
      }
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.name
  description        = "Role assigned to the ${var.name} OIDC role (generated by Terraform)"
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role_with_oidc.*.json)

  tags = var.tags
}

resource "aws_iam_policy" "this" {
  count = var.policy_json == null ? 0 : 1

  name        = replace(var.name, "iamrole", "iampolicy")
  description = "User-managed policy assigned to the ${var.name} role (generated by Terraform)"
  policy      = var.policy_json

  # tags not supported
}

resource "aws_iam_role_policy_attachment" "from_json" {
  count = var.policy_json == null ? 0 : 1

  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this[count.index].arn

  # tags not supported
}

resource "aws_iam_role_policy_attachment" "from_arn" {
  count = length(var.policy_arn) == 0 ? 0 : length(var.policy_arn)

  role       = aws_iam_role.this.name
  policy_arn = var.policy_arn[count.index]

  # tags not supported
}
