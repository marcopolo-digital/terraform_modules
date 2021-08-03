output "arn" {
  value       = aws_ssoadmin_permission_set.this.arn
  description = "The Amazon Resource Name (ARN) of the Permission Set."
}

output "id" {
  value       = aws_ssoadmin_permission_set.this.id
  description = "The Amazon Resource Names (ARNs) of the Permission Set and SSO Instance, separated by a comma (,)."
}

output "created_date" {
  value       = aws_ssoadmin_permission_set.this.created_date
  description = "The date the Permission Set was created in RFC3339 format."
}