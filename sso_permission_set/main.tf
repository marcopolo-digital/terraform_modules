resource "aws_ssoadmin_permission_set" "this" {
  name             = var.name
  description      = var.description
  instance_arn     = var.instance_arn
  relay_state      = var.relay_state
  session_duration = var.session_duration

  tags = var.tags
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = var.managed_policy_arns == [] ? [] : toset(var.managed_policy_arns)

  managed_policy_arn = each.key
  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  # tags not supported
}


resource "aws_ssoadmin_permission_set_inline_policy" "this" {
  count = var.inline_policy == "" ? 0: 1

  inline_policy      = var.inline_policy
  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  # tags not supported
}