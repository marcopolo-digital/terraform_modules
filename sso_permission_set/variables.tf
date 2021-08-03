variable "name" {
  description = "(Required) The name of the Permission Set."
  type        = string
}

variable "instance_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the SSO Instance under which the operation will be executed."
  type        = string
}

variable "description" {
  description = "(Optional) The description of the Permission Set."
  type        = string
  default     = null
}

variable "relay_state" {
  description = "(Optional) The relay state URL used to redirect users within the application during the federation authentication process."
  type        = string
  default     = null
}

variable "session_duration" {
  description = "(Optional) The length of time that the application user sessions are valid in the ISO-8601 standard. Default: PT1H."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(string)
  default     = null
}

variable "managed_policy_arns" {
  description = "(Optional) List of IAM managed policy Amazon Resource Name (ARN) to be attached to the Permission Set."
  type        = list(string)
  default     = []
}

variable "inline_policy" {
  description = "(Optional) The IAM inline policy to attach to a Permission Set."
  type        = string
  default     = ""
}