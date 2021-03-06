terraform {
  required_version = ">=0.14.0"
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_instance_role ? 1 : 0

  name = var.name
  role = aws_iam_role.this.name

  # tags not supported
}

resource "aws_iam_role" "this" {
  name               = var.name
  description        = "Role assigned to the ${var.name} Profile instance profile (generated by Terraform)"
  assume_role_policy = var.assume_role_policy != null ?  var.assume_role_policy : data.aws_iam_policy_document.role.json

  tags = var.tags
}

data "aws_iam_policy_document" "role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["${var.role_policy_service}.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "this" {
  count = var.policy_json == null ? 0 : 1

  name        = replace(var.name, "iamrole", "iampolicy")
  description = "User-managed policy assigned to the ${var.name} Role role (generated by Terraform)"
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