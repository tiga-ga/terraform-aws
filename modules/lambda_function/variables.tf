variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role for the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
  default     = "python3.10"
}

variable "handler" {
  description = "Handler for the Lambda function"
  type        = string
}

variable "timeout" {
  description = "Timeout for the Lambda function"
  type        = number
  default     = 300
}

variable "source_file" {
  description = "Source file for the Lambda function"
  type        = string
}

variable "lambda_layer_arn" {
  description = "ARN of the Lambda layer"
  type        = list(any)
  default     = []
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "security_group_ids" {
  description = "Security group IDs for the Lambda function"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Subnet IDs for the Lambda function"
  type        = list(string)
  default     = []
}

variable "dependency_resources" {
  description = "Resources the Lambda function depends on"
  type        = list(any)
  default     = []
}
