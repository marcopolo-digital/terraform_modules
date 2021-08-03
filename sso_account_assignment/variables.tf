variable "instance_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the SSO Instance."
  type        = string
}

variable "permission_rules" {
  description = "(Required) - Permission rule and identity store id to assign to an AWS account"
  type        = list(object({
    principal_id        = string
    principal_type      = string
    permission_set_arns = list(string)
  }))
}

variable "target_id" {
  description = "(Required) An AWS account identifier, typically a 10-12 digit string."
  type        = string
}

variable "target_type" {
  description = "(Optional) The entity type for which the assignment will be created"
  type        = string
  default     = "AWS_ACCOUNT"
}
