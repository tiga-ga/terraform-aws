variable "layer_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Compatible runtimes for the Lambda layer"
  type        = string
}

variable "source_file" {
  description = "Directory containing the Lambda layer source code"
  type        = string
}
