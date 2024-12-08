variable "iam_role_name" {
  description = "Name of the IAM Role"
  type        = string
}

variable "iam_assume_role_policy" {
  description = "IAM Assume Role Policy"
  type = object({
    Effect = string
    Principal = object({
      Service = string
    })
    Action = string
  })
}

variable "iam_policy_name" {
  description = "Name of the IAM Policy"
  type        = string
}

variable "iam_policy_statements" {
  description = "Policy statements for the custom IAM Policy"
  type = list(object({
    Effect   = string
    Action   = list(string)
    Resource = list(string)
  }))
  default = []
}

variable "managed_policy_arns" {
  description = "List of ARNs for managed policies to attach"
  type        = list(string)
  default     = []
}

variable "dependency_resources" {
  description = "List of resources to depend on"
  default     = []
}
