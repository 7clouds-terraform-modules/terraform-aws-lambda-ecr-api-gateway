output "AWS_CALLER_IDENTITY_ACCOUNT_ID" {
  description = "Account ID for usage as reference"
  value       = data.aws_caller_identity.current_identity.account_id
}

output "AWS_DEFAULT_REGION_DATA" {
  description = "Data to get the default region for usage as reference and making 'AWS_REGION' an optional variable "
  value       = data.aws_region.default_region.name
}

output "PROJECT_NAME" {
  description = "The project name that will be prefixed to resource names"
  value       = var.PROJECT_NAME
}

output "API_GATEWAY_RESOURCE_PATH" {
  description = "API Gateway Resource Path"
  value       = var.API_GATEWAY_RESOURCE_PATH
}

output "API_GATEWAY_METHOD_AUTHORIZATION" {
  description = "API Gateway Method Authorization"
  value       = var.API_GATEWAY_METHOD_AUTHORIZATION

}

output "API_GATEWAY_METHOD_HTTP_METHOD" {
  description = "HTTP Method"
  value       = var.API_GATEWAY_METHOD_HTTP_METHOD
}

output "API_GATEWAY_METHOD_ROOT_AUTHORIZATION" {
  description = "API Gateway Method Authorization"
  value       = var.API_GATEWAY_METHOD_ROOT_AUTHORIZATION

}

output "API_GATEWAY_METHOD_ROOT_HTTP_METHOD" {
  description = "HTTP Method"
  value       = var.API_GATEWAY_METHOD_ROOT_HTTP_METHOD
}

output "ENVIRONMENT" {
  description = "Environment Name"
  value       = var.ENVIRONMENT
}

output "AWS_REGION" {
  description = "AWS Region - If set as 'null', a data will set your default region from configuration file as value"
  value       = var.AWS_REGION
}

output "TAGS" {
  description = "Tag List"
  value       = var.TAGS
}

output "ECR_REPOSITORY_NAME" {
  description = "Name of the ECR Repository"
  value       = var.ECR_REPOSITORY_NAME
}

output "ECR_IMAGE_TAG" {
  description = "Tag associated with this image"
  value       = var.ECR_IMAGE_TAG
}

output "API_GATEWAY_INTEGRATION_INPUT_TYPE" {
  description = "Integration input's type. 'AWS_PROXY' was set for Lambda Proxy Integration"
  value       = var.API_GATEWAY_INTEGRATION_INPUT_TYPE
}

output "API_GATEWAY_INTEGRATION_HTTP_METHOD" {
  description = "Integration HTTP method specifying how API Gateway will interact with the back end. Lambda function can only be invoked via POST."
  value       = var.API_GATEWAY_INTEGRATION_HTTP_METHOD
}

output "API_GATEWAY_INTEGRATION_ROOT_TYPE" {
  description = "Integration input's type. 'AWS_PROXY' was set for Lambda Proxy Integration"
  value       = var.API_GATEWAY_INTEGRATION_ROOT_TYPE
}

output "API_GATEWAY_INTEGRATION_ROOT_HTTP_METHOD" {
  description = "Integration HTTP method specifying how API Gateway will interact with the back end. Lambda function can only be invoked via POST."
  value       = var.API_GATEWAY_INTEGRATION_ROOT_HTTP_METHOD
}

output "ATTACHED_POLICY_ARNS" {
  description = "Policy ARNs to be added to Lambda Function"
  value       = var.ATTACHED_POLICY_ARNS
}

output "MEMORY_SIZE" {
  description = "Lambda Function Memory Size"
  value       = var.MEMORY_SIZE
}

output "TIMEOUT" {
  description = "Timeout for lambda function"
  value       = var.TIMEOUT
}

output "ENVIRONMENT_VARIABLES" {
  description = "Lambda Environment variables List"
  value       = var.ENVIRONMENT_VARIABLES
}

output "SECURITY_GROUP_IDS" {
  description = "Security Group ID to be referenced on Lambda Function"
  value       = var.SECURITY_GROUP_IDS
}

output "SUBNET_IDS" {
  description = "Subnet IDs to be referenced on Lambda Function"
  value       = var.SUBNET_IDS
}

output "WARMUP_ENABLED" {
  description = "Boolean to define whether this lambda function will have WarmUp Event triggered By CloudWatch "
  value       = var.WARMUP_ENABLED
}

output "LAMBDA_WARMUP_SCHEDULE_EXPRESSION" {
  description = "Schedule Expression for Lambda Warm Up Events Rule"
  value       = var.LAMBDA_WARMUP_SCHEDULE_EXPRESSION
}

output "REST_API_ENDPOINT" {
  description = "API Gateway swagger endpoint URL for current stage"
  value       = "${aws_api_gateway_stage.api_gateway_stage.invoke_url}"
}

output "API_GATEWAY_STAGE_ARN" {
  description = "API Gateway Stage ARN for references"
  value       = aws_api_gateway_stage.api_gateway_stage.arn
}

output "CLOUDWATCH_LAMBDA_WARMUP_EVENTS_RULE_ARN" {
  description = "API Gateway Stage ARN for references"
  value       = join("", aws_cloudwatch_event_rule.lambda_warm_up_events_rule.*.arn)
}