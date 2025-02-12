# Lambda Function ECR + API Gateway Module by 7Clouds

Thank you for riding with us! Feel free to download or reference this respository in your terraform projects and studies

This module is a part of our product SCA — An automated API and Serverless Infrastructure generator that can reduce your API development time by 40-60% and automate your deployments up to 90%! Check it out at <https://seventechnologies.cloud>

Please star rate this repo if you like our job!

## Usage

The module deploys a set of Lambda Function using an ECR image as its code + API Gateway resources with its rightful roles and policies to create a serverless application.

## Example

```hcl
module "lambda_ecr_api_gateway" {
  source = "../.."

  # Required
  PROJECT_NAME                     = "NewModules"
  API_GATEWAY_RESOURCE_PATH        = "{proxy+}"
  API_GATEWAY_METHOD_AUTHORIZATION = "NONE"
  API_GATEWAY_METHOD_HTTP_METHOD   = "ANY"
  ENVIRONMENT                      = "DEV"

  # Optionals
  AWS_REGION = "us-west-2"
  TAGS = { Enviromnet = "Example"
    Terraform = true
  }

  # Structural
  LAMBDA_CODE_IMAGE_URI               = "YourECRImageURIHere"
  SECURITY_GROUP_IDS                  = ["YourSecurityGroupsID(s)Here"]
  SUBNET_IDS                          = ["YourSubnetsID(s)Here"]
  WARMUP_ENABLED                      = true
  LAMBDA_WARMUP_SCHEDULE_EXPRESSION   = "rate(5 minutes)"
  MEMORY_SIZE                         = 128
  TIMEOUT                             = 60
  ENVIRONMENT_VARIABLES               = { foo = "bar" }
  ATTACHED_POLICY_ARNS                 = ["YourAttachedPolic(y/ies)Here"]
  API_GATEWAY_INTEGRATION_HTTP_METHOD = "POST"
  API_GATEWAY_INTEGRATION_INPUT_TYPE  = "AWS_PROXY"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_deployment.api_gateway_deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_integration.api_gateway_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration.api_gateway_integration_lambda_proxy_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_method.api_gateway_method](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method.api_gateway_method_proxy_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_resource.api_gateway_resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_rest_api.rest_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_stage.api_gateway_stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_cloudwatch_event_rule.lambda_warm_up_events_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda_warm_up_events_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.lambda_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachments_exclusive.lambda_iam_role_policy_attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_lambda_function.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.lambda_permission_api_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.lambda_permission_warm_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_caller_identity.current_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.default_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_API_GATEWAY_INTEGRATION_HTTP_METHOD"></a> [API\_GATEWAY\_INTEGRATION\_HTTP\_METHOD](#input\_API\_GATEWAY\_INTEGRATION\_HTTP\_METHOD) | Integration HTTP method specifying how API Gateway will interact with the back end. Lambda function can only be invoked via POST. | `string` | `"POST"` | no |
| <a name="input_API_GATEWAY_INTEGRATION_INPUT_TYPE"></a> [API\_GATEWAY\_INTEGRATION\_INPUT\_TYPE](#input\_API\_GATEWAY\_INTEGRATION\_INPUT\_TYPE) | Integration input's type. 'AWS\_PROXY' was set for Lambda Proxy Integration | `string` | `"AWS_PROXY"` | no |
| <a name="input_API_GATEWAY_METHOD_AUTHORIZATION"></a> [API\_GATEWAY\_METHOD\_AUTHORIZATION](#input\_API\_GATEWAY\_METHOD\_AUTHORIZATION) | API Gateway Method Authorization | `string` | n/a | yes |
| <a name="input_API_GATEWAY_METHOD_HTTP_METHOD"></a> [API\_GATEWAY\_METHOD\_HTTP\_METHOD](#input\_API\_GATEWAY\_METHOD\_HTTP\_METHOD) | API Gateway HTTP Method | `string` | n/a | yes |
| <a name="input_API_GATEWAY_RESOURCE_PATH"></a> [API\_GATEWAY\_RESOURCE\_PATH](#input\_API\_GATEWAY\_RESOURCE\_PATH) | API Gateway Resource Path | `string` | n/a | yes |
| <a name="input_ATTACHED_POLICY_ARNS"></a> [ATTACHED\_POLICY\_ARNS](#input\_ATTACHED\_POLICY\_ARNS) | Policy ARNs to be added to Lambda Function | `list(string)` | `null` | no |
| <a name="input_AWS_REGION"></a> [AWS\_REGION](#input\_AWS\_REGION) | AWS Region - If set as 'null', a data will set your default region from configuration file as value | `string` | `null` | no |
| <a name="input_ENVIRONMENT"></a> [ENVIRONMENT](#input\_ENVIRONMENT) | Environment Name | `string` | n/a | yes |
| <a name="input_ENVIRONMENT_VARIABLES"></a> [ENVIRONMENT\_VARIABLES](#input\_ENVIRONMENT\_VARIABLES) | Lambda Environment Variables List | `map(any)` | `{}` | no |
| <a name="input_LAMBDA_CODE_IMAGE_URI"></a> [LAMBDA\_CODE\_IMAGE\_URI](#input\_LAMBDA\_CODE\_IMAGE\_URI) | ECR image URI containing the function's deployment package | `string` | `null` | no |
| <a name="input_LAMBDA_CODE_PACKAGE_TYPE"></a> [LAMBDA\_CODE\_PACKAGE\_TYPE](#input\_LAMBDA\_CODE\_PACKAGE\_TYPE) | Lambda deployment package type. For this module, we must use the value Image | `string` | `"Image"` | no |
| <a name="input_LAMBDA_WARMUP_SCHEDULE_EXPRESSION"></a> [LAMBDA\_WARMUP\_SCHEDULE\_EXPRESSION](#input\_LAMBDA\_WARMUP\_SCHEDULE\_EXPRESSION) | Schedule Expression for Lambda Warm Up Events Rule | `string` | `"rate(5 minutes)"` | no |
| <a name="input_MEMORY_SIZE"></a> [MEMORY\_SIZE](#input\_MEMORY\_SIZE) | Lambda Function Memory Size | `number` | `128` | no |
| <a name="input_PROJECT_NAME"></a> [PROJECT\_NAME](#input\_PROJECT\_NAME) | The project name that will be prefixed to resource names | `string` | n/a | yes |
| <a name="input_SECURITY_GROUP_IDS"></a> [SECURITY\_GROUP\_IDS](#input\_SECURITY\_GROUP\_IDS) | Security Group ID to be referenced on Lambda Function | `list(any)` | `[]` | no |
| <a name="input_SUBNET_IDS"></a> [SUBNET\_IDS](#input\_SUBNET\_IDS) | Subnet IDs to be referenced on Lambda Function | `list(any)` | `[]` | no |
| <a name="input_TAGS"></a> [TAGS](#input\_TAGS) | Tag List | `map(string)` | `null` | no |
| <a name="input_TIMEOUT"></a> [TIMEOUT](#input\_TIMEOUT) | Timeout for lambda function | `number` | `60` | no |
| <a name="input_WARMUP_ENABLED"></a> [WARMUP\_ENABLED](#input\_WARMUP\_ENABLED) | Boolean to define whether this lambda function will have WarmUp Event triggered By CloudWatch | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_API_GATEWAY_INTEGRATION_HTTP_METHOD"></a> [API\_GATEWAY\_INTEGRATION\_HTTP\_METHOD](#output\_API\_GATEWAY\_INTEGRATION\_HTTP\_METHOD) | Integration HTTP method specifying how API Gateway will interact with the back end. Lambda function can only be invoked via POST. |
| <a name="output_API_GATEWAY_INTEGRATION_INPUT_TYPE"></a> [API\_GATEWAY\_INTEGRATION\_INPUT\_TYPE](#output\_API\_GATEWAY\_INTEGRATION\_INPUT\_TYPE) | Integration input's type. 'AWS\_PROXY' was set for Lambda Proxy Integration |
| <a name="output_API_GATEWAY_METHOD_AUTHORIZATION"></a> [API\_GATEWAY\_METHOD\_AUTHORIZATION](#output\_API\_GATEWAY\_METHOD\_AUTHORIZATION) | API Gateway Method Authorization |
| <a name="output_API_GATEWAY_METHOD_HTTP_METHOD"></a> [API\_GATEWAY\_METHOD\_HTTP\_METHOD](#output\_API\_GATEWAY\_METHOD\_HTTP\_METHOD) | HTTP Method |
| <a name="output_API_GATEWAY_RESOURCE_PATH"></a> [API\_GATEWAY\_RESOURCE\_PATH](#output\_API\_GATEWAY\_RESOURCE\_PATH) | API Gateway Resource Path |
| <a name="output_API_GATEWAY_STAGE_ARN"></a> [API\_GATEWAY\_STAGE\_ARN](#output\_API\_GATEWAY\_STAGE\_ARN) | API Gateway Stage ARN for references |
| <a name="output_ATTACHED_POLICY_ARNS"></a> [ATTACHED\_POLICY\_ARNS](#output\_ATTACHED\_POLICY\_ARNS) | Policy ARNs to be added to Lambda Function |
| <a name="output_AWS_CALLER_IDENTITY_ACCOUNT_ID"></a> [AWS\_CALLER\_IDENTITY\_ACCOUNT\_ID](#output\_AWS\_CALLER\_IDENTITY\_ACCOUNT\_ID) | Account ID for usage as reference |
| <a name="output_AWS_DEFAULT_REGION_DATA"></a> [AWS\_DEFAULT\_REGION\_DATA](#output\_AWS\_DEFAULT\_REGION\_DATA) | Data to get the default region for usage as reference and making 'AWS\_REGION' an optional variable |
| <a name="output_AWS_REGION"></a> [AWS\_REGION](#output\_AWS\_REGION) | AWS Region - If set as 'null', a data will set your default region from configuration file as value |
| <a name="output_CLOUDWATCH_LAMBDA_WARMUP_EVENTS_RULE_ARN"></a> [CLOUDWATCH\_LAMBDA\_WARMUP\_EVENTS\_RULE\_ARN](#output\_CLOUDWATCH\_LAMBDA\_WARMUP\_EVENTS\_RULE\_ARN) | API Gateway Stage ARN for references |
| <a name="output_ENVIRONMENT"></a> [ENVIRONMENT](#output\_ENVIRONMENT) | Environment Name |
| <a name="output_ENVIRONMENT_VARIABLES"></a> [ENVIRONMENT\_VARIABLES](#output\_ENVIRONMENT\_VARIABLES) | Lambda Environment variables List |
| <a name="output_LAMBDA_WARMUP_SCHEDULE_EXPRESSION"></a> [LAMBDA\_WARMUP\_SCHEDULE\_EXPRESSION](#output\_LAMBDA\_WARMUP\_SCHEDULE\_EXPRESSION) | Schedule Expression for Lambda Warm Up Events Rule |
| <a name="output_MEMORY_SIZE"></a> [MEMORY\_SIZE](#output\_MEMORY\_SIZE) | Lambda Function Memory Size |
| <a name="output_PROJECT_NAME"></a> [PROJECT\_NAME](#output\_PROJECT\_NAME) | The project name that will be prefixed to resource names |
| <a name="output_REST_API_ENDPOINT"></a> [REST\_API\_ENDPOINT](#output\_REST\_API\_ENDPOINT) | API Gateway swagger endpoint URL for current stage |
| <a name="output_SECURITY_GROUP_IDS"></a> [SECURITY\_GROUP\_IDS](#output\_SECURITY\_GROUP\_IDS) | Security Group ID to be referenced on Lambda Function |
| <a name="output_SUBNET_IDS"></a> [SUBNET\_IDS](#output\_SUBNET\_IDS) | Subnet IDs to be referenced on Lambda Function |
| <a name="output_TAGS"></a> [TAGS](#output\_TAGS) | Tag List |
| <a name="output_TIMEOUT"></a> [TIMEOUT](#output\_TIMEOUT) | Timeout for lambda function |
| <a name="output_WARMUP_ENABLED"></a> [WARMUP\_ENABLED](#output\_WARMUP\_ENABLED) | Boolean to define whether this lambda function will have WarmUp Event triggered By CloudWatch |
<!-- END_TF_DOCS -->