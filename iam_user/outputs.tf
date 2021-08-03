output "iam_user_name" {
  description = "The user's name"
  value       = aws_iam_user.this.name
}

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_user.this.arn
}

output "iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = aws_iam_user.this.unique_id
}


output "iam_access_key_id" {
  description = "The access key ID"
  value       = element(
  concat(
  aws_iam_access_key.this.*.id,
  aws_iam_access_key.this_no_pgp.*.id,
  [""],
  ),
  0
  )
  sensitive   = true
}

output "iam_access_key_secret" {
  description = "The access key secret"
  value       = element(concat(aws_iam_access_key.this_no_pgp.*.secret, [""]), 0)
  sensitive   = true
}

output "iam_access_key_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = element(concat(aws_iam_access_key.this.*.key_fingerprint, [""]), 0)
}

output "iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = element(concat(aws_iam_access_key.this.*.encrypted_secret, [""]), 0)
}