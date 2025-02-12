data "aws_caller_identity" "current_identity" {}

data "aws_region" "default_region" {}

resource "aws_api_gateway_rest_api" "rest_api" {
  name = "${var.PROJECT_NAME}RestAPI"
  tags = var.TAGS != null ? "${merge(var.TAGS, { Name = "${var.PROJECT_NAME} Rest API" })}" : { Name = "${var.PROJECT_NAME} Rest API" }
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = var.API_GATEWAY_RESOURCE_PATH
}

resource "aws_api_gateway_method" "api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource.id
  http_method   = var.API_GATEWAY_METHOD_HTTP_METHOD
  authorization = var.API_GATEWAY_METHOD_AUTHORIZATION
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method" "api_gateway_method_root" {
   rest_api_id   = aws_api_gateway_rest_api.rest_api.id
   resource_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
   http_method   = var.API_GATEWAY_METHOD_ROOT_HTTP_METHOD
   authorization = var.API_GATEWAY_METHOD_ROOT_AUTHORIZATION
}

resource "aws_api_gateway_integration" "api_gateway_integration" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.api_gateway_resource.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
  type                    = var.API_GATEWAY_INTEGRATION_INPUT_TYPE
  uri                     = "arn:aws:apigateway:${var.AWS_REGION != null ? var.AWS_REGION : data.aws_region.default_region.name}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.AWS_REGION != null ? var.AWS_REGION : data.aws_region.default_region.name}:${data.aws_caller_identity.current_identity.account_id}:function:$${stageVariables.FunctionName}/invocations"
  integration_http_method = var.API_GATEWAY_INTEGRATION_HTTP_METHOD
}

resource "aws_api_gateway_integration" "api_gateway_integration_root" {
   rest_api_id = aws_api_gateway_rest_api.rest_api.id
   resource_id = aws_api_gateway_method.api_gateway_method_root.resource_id
   http_method = aws_api_gateway_method.api_gateway_method_root.http_method
   integration_http_method = var.API_GATEWAY_INTEGRATION_ROOT_HTTP_METHOD
   type                    = var.API_GATEWAY_INTEGRATION_ROOT_TYPE
   uri                     = "arn:aws:apigateway:${var.AWS_REGION != null ? var.AWS_REGION : data.aws_region.default_region.name}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.AWS_REGION != null ? var.AWS_REGION : data.aws_region.default_region.name}:${data.aws_caller_identity.current_identity.account_id}:function:$${stageVariables.FunctionName}/invocations"
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  depends_on  = [aws_api_gateway_integration.api_gateway_integration]
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  stage_name    = var.ENVIRONMENT
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  variables = {
    FunctionName = "${var.PROJECT_NAME}LambdaFunction"
  }
  tags       = var.TAGS != null ? "${merge(var.TAGS, { Name = "${var.PROJECT_NAME} API Gateway Stage" })}" : { Name = "${var.PROJECT_NAME} API Gateway Stage" }
  depends_on = [aws_api_gateway_deployment.api_gateway_deployment]
}

resource "aws_iam_role" "lambda_iam_role" {
  description = "IAM role for ${var.PROJECT_NAME} application"
  name        = "${var.PROJECT_NAME}LambdaIamRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
    }]
  })
  tags = var.TAGS != null ? "${merge(var.TAGS, { Name = "${var.PROJECT_NAME} Lambda Iam Role" })}" : { Name = "${var.PROJECT_NAME} Lambda Iam Role" }
}

resource "aws_iam_role_policy_attachments_exclusive" "lambda_iam_role_policy_attachments" {
  role_name   = aws_iam_role.lambda_iam_role.name
  policy_arns = var.ATTACHED_POLICY_ARNS != null ? concat(var.ATTACHED_POLICY_ARNS,
    [
      "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
      "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator",
      "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
    ]) : [
    "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator",
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
  ]
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "${var.PROJECT_NAME}LambdaFunction"
  memory_size   = var.MEMORY_SIZE
  timeout       = var.TIMEOUT
  image_uri     = var.LAMBDA_CODE_IMAGE_URI
  package_type  = var.LAMBDA_CODE_PACKAGE_TYPE
  role          = aws_iam_role.lambda_iam_role.arn
  environment {
    variables = var.ENVIRONMENT_VARIABLES
  }
  vpc_config {
    security_group_ids = var.SECURITY_GROUP_IDS
    subnet_ids         = var.SUBNET_IDS
  }
  tags = var.TAGS != null ? "${merge(var.TAGS, { Name = "${var.PROJECT_NAME} Lambda Function" })}" : { Name = "${var.PROJECT_NAME} Lambda Function" }
}

resource "aws_lambda_permission" "lambda_permission_api_gateway" {
  function_name = aws_lambda_function.lambda_function.function_name
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.rest_api.execution_arn}/${var.ENVIRONMENT}/*/*"
  depends_on    = [aws_lambda_function.lambda_function]
}

resource "aws_cloudwatch_event_rule" "lambda_warm_up_events_rule" {
  count               = var.WARMUP_ENABLED ? 1 : 0
  schedule_expression = var.LAMBDA_WARMUP_SCHEDULE_EXPRESSION
  tags                = var.TAGS != null ? "${merge(var.TAGS, { Name = "${var.PROJECT_NAME} Lambda WarmUp Events Rule" })}" : { Name = "${var.PROJECT_NAME} Lambda WarmUp Events Rule" }
}

resource "aws_lambda_permission" "lambda_permission_warm_up" {
  count         = var.WARMUP_ENABLED ? 1 : 0
  function_name = aws_lambda_function.lambda_function.function_name
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_lambda_function.lambda_function.arn}/${var.ENVIRONMENT}/*/*"
  depends_on    = [aws_lambda_function.lambda_function]
}

resource "aws_cloudwatch_event_target" "lambda_warm_up_events_target" {
  count      = var.WARMUP_ENABLED ? 1 : 0
  target_id  = "${lower(var.PROJECT_NAME)}_lambda_warm_up_events_target"
  arn        = aws_lambda_function.lambda_function.arn
  rule       = element(aws_cloudwatch_event_rule.lambda_warm_up_events_rule.*.id, count.index)
  depends_on = [aws_lambda_permission.lambda_permission_warm_up]
}