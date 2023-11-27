
locals {
  region      = "us-east-2"
  environment = "prod"
  name        = "skaf"
  account_id  = "271251951598"
  additional_tags = {
    Owner      = "SquareOps"
    Expires    = "Never"
    Department = "Engineering"
    Product    = "Atmosly"
  }
}

module "aws_budget_alert" {
  source = "../../"
  name   = local.name
  environment = local.environment
  account_id  = local.account_id
  budget_type = "COST"
  limit_amount= "10"
  limit_unit  = "USD"
  time_period_start = "2023-11-16_00:00"
  time_unit   = "DAILY"
  notification = {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
  }
  cost_types = {
    include_credit             = false
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = false
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_blended                = false
  }
  slack_notification_enabled = true
  slack_channel_id   = "C0638MUDWUD"
  slack_workspace_id = "TB5FXBSUE"
  email_notification_enabled = false
  email_address = ""
}


