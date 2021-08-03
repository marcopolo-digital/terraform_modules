output "instance_profile_name" {
  description = "The Instance profile Name"
  value       = length(aws_iam_instance_profile.this) > 0 ? aws_iam_instance_profile.this[0].name : null
}

output "instance_profile_arn" {
  description = "The Instance profile ARN"
  value       = length(aws_iam_instance_profile.this) > 0 ? aws_iam_instance_profile.this[0].arn : null
}

output "role_arn" {
  description = "The IAM Role ARN"
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "The IAM Role name"
  value       = aws_iam_role.this.name
}