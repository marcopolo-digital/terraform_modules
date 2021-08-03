variable "name" {
  description = "The name of the IAM Role."
  type        = string
}

variable "provider_urls" {
  description = "List of URLs of the OIDC Providers"
  type        = list(string)
  default     = []
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = ""
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

variable "oidc_fully_qualified_subjects" {
  description = "The fully qualified OIDC subjects to be added to the role policy"
  type        = set(string)
  default     = []
}

variable "oidc_subjects_with_wildcards" {
  description = "The OIDC subject using wildcards to be added to the role policy"
  type        = set(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}