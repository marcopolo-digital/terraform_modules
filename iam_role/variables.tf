variable "name" {
  description = "The name of the IAM Role."
  type        = string
}

variable "role_policy_service" {
  description = ""
  type        = string
  default     = "ec2"
}

variable "assume_role_policy" {
  type = string
  default = null
}

variable "policy_json" {
  description = "(Optional) The policy content to add to the new IAM Role."
  type        = string
  default     = null
}

variable "policy_arn" {
  description = "(Optional) The policy ARN to add to the new IAM Role."
  type        = list(string)
  default     = []
}

variable "create_instance_role" {
  description = "(Optional) Create EC2 instance_profile"
  type        = bool
  default     = false
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(string)
  default     = null
}


