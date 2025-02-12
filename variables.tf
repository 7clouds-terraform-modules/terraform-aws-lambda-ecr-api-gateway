# Required
variable "PROJECT_NAME" {
  description = "The project name that will be prefixed to resource names"
  type        = string
}

variable "API_GATEWAY_RESOURCE_PATH" {
  description = "API Gateway Resource Path"
  type        = string
}

variable "API_GATEWAY_METHOD_AUTHORIZATION" {
  description = "API Gateway Method Authorization"
  type        = string
}

variable "API_GATEWAY_METHOD_HTTP_METHOD" {
  description = "API Gateway HTTP Method"
  type        = string
}

variable "API_GATEWAY_METHOD_ROOT_AUTHORIZATION" {
  description = "API Gateway Method Authorization"
  type        = string
  default     = "NONE"
}

variable "API_GATEWAY_METHOD_ROOT_HTTP_METHOD" {
  description = "API Gateway HTTP Method"
  type        = string
  default     = "ANY"
}

variable "ENVIRONMENT" {
  description = "Environment Name"
  type        = string
}

# Optional

variable "AWS_REGION" {
  description = "AWS Region - If set as 'null', a data will set your default region from configuration file as value"
  type        = string
  default     = null
}

variable "TAGS" {
  description = "Tag List"
  type        = map(string)
  default     = null
}

# Structural

variable "API_GATEWAY_INTEGRATION_INPUT_TYPE" {
  description = "Integration input's type. 'AWS_PROXY' was set for Lambda Proxy Integration"
  type        = string
  default     = "AWS_PROXY"
}

variable "API_GATEWAY_INTEGRATION_HTTP_METHOD" {
  description = "Integration HTTP method specifying how API Gateway will interact with the back end. Lambda function can only be invoked via POST."
  type        = string
  default     = "POST"
}

variable "API_GATEWAY_INTEGRATION_ROOT_TYPE" {
  description = "Integration input's type. 'AWS_PROXY' was set for Lambda Proxy Integration"
  type        = string
  default     = "AWS_PROXY"
}

variable "API_GATEWAY_INTEGRATION_ROOT_HTTP_METHOD" {
  description = "Integration HTTP method specifying how API Gateway will interact with the back end. Lambda function can only be invoked via POST."
  type        = string
  default     = "POST"
}

variable "ATTACHED_POLICY_ARNS" {
  description = "Policy ARNs to be added to Lambda Function"
  type        = list(string)
  default     = null
}

variable "MEMORY_SIZE" {
  description = "Lambda Function Memory Size"
  type        = number
  default     = 128
}

variable "TIMEOUT" {
  description = "Timeout for lambda function"
  type        = number
  default     = 60
}

variable "LAMBDA_CODE_PACKAGE_TYPE" {
  description = "Lambda deployment package type. For this module, we must use the value Image"
  type        = string
  default     = "Image"
}

variable "LAMBDA_CODE_IMAGE_URI" {
  description = "ECR image URI containing the function's deployment package"
  type        = string
  default     = null
}

variable "ENVIRONMENT_VARIABLES" {
  description = "Lambda Environment Variables List"
  type        = map(any)
  default     = {}
}

variable "SECURITY_GROUP_IDS" {
  description = "Security Group ID to be referenced on Lambda Function"
  type        = list(any)
  default     = []
}

variable "SUBNET_IDS" {
  description = "Subnet IDs to be referenced on Lambda Function"
  type        = list(any)
  default     = []
}

variable "WARMUP_ENABLED" {
  description = "Boolean to define whether this lambda function will have WarmUp Event triggered By CloudWatch "
  type        = bool
  default     = false
}

variable "LAMBDA_WARMUP_SCHEDULE_EXPRESSION" {
  description = "Schedule Expression for Lambda Warm Up Events Rule"
  type        = string
  default     = "rate(5 minutes)"
}