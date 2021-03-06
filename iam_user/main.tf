terraform {
  required_version = ">=0.14.0"
}

resource "aws_iam_user" "this" {
  name                 = var.name
  path                 = var.path
  force_destroy        = var.force_destroy
  permissions_boundary = var.permissions_boundary

  tags                 = var.tags
}

resource "aws_iam_access_key" "this" {
  count   = var.create_iam_access_key && var.pgp_key != "" ? 1 : 0
  user    = aws_iam_user.this.name
  pgp_key = var.pgp_key
}

resource "aws_iam_access_key" "this_no_pgp" {
  count = var.create_iam_access_key && var.pgp_key == "" ? 1 : 0
  user  = aws_iam_user.this.name
}

resource "aws_iam_policy" "this" {
  count = var.policy_json == "" ? 0 : 1

  name        = replace(var.name, "iamuser", "iampolicy")
  description = "User-managed policy assigned to the ${var.name} User role (generated by Terraform)"
  policy      = var.policy_json

  # tags not supported
}

resource "aws_iam_user_policy_attachment" "from_json" {
  count = var.policy_json == "" ? 0 : 1

  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this[count.index].arn

  # tags not supported
}

resource "aws_iam_user_policy_attachment" "from_arn" {
  count = length(var.policy_arn) == 0 ? 0 : length(var.policy_arn)

  user       = aws_iam_user.this.name
  policy_arn = var.policy_arn[count.index]

  # tags not supported
}