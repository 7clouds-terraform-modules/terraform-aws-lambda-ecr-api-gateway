module "lambda_ecr_api_gateway" {
  source = "../.."

  # Required
  PROJECT_NAME                     = "NewModules"
  API_GATEWAY_RESOURCE_PATH        = "{proxy+}"
  API_GATEWAY_METHOD_AUTHORIZATION = "NONE"
  API_GATEWAY_METHOD_HTTP_METHOD   = "ANY"
  ENVIRONMENT                      = "DEV"
  ECR_REPOSITORY_NAME              = "lambda/newmodules-ecr"
  ECR_IMAGE_TAG                    = "latest"

  # Optionals
  AWS_REGION = "us-west-2"
  TAGS = { Environment = "Example"
    Terraform = true
  }

  # Structural
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