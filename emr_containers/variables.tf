variable "eks_cluster_name" {
  description = ""
  type = string
}

variable "eks_namespace" {
  description = ""
  type = string
}

variable "emr_virtual_cluster_name" {
  description = ""
  type = string
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(string)
  default     = null
}


