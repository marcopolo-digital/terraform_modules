locals {
  permission_rules = flatten([
    for rule in var.permission_rules : [
      for permission_set in lookup(rule, "permission_set_arns") : {
        principal_id       = lookup(rule, "principal_id")
        principal_type     = lookup(rule, "principal_type")
        permission_set_arn = permission_set
      }
      ]
    ])
}

# for_each not working here correctly. count had to be used as workaround
resource "aws_ssoadmin_account_assignment" "this" {
  count = length(local.permission_rules)

  permission_set_arn = lookup(local.permission_rules[count.index], "permission_set_arn")
  principal_id       = lookup(local.permission_rules[count.index], "principal_id")
  principal_type     = lookup(local.permission_rules[count.index], "principal_type")

  instance_arn = var.instance_arn
  target_id    = var.target_id
  target_type  = var.target_type
}