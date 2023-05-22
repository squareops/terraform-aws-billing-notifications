module "cost_mgmt_notif" {
  source = "../../../terraform-aws-cost-budget"

  environment          = "dev"
  currency             = "USD"
  limit_amount         = 50
  time_unit            = "DAILY"
  time_period_start    = "2023-01-01_00:00"
  # time_period_end      = "2023-12-31_23:59"
  cost_filters_service = "Amazon Elastic Compute Cloud - Compute"
  aws_sns_account_id   = "271251951598"
}

output "sns_topic" {
  description = "List of SNS Topic ARN sto be subscribed to in order to delivery the budget billing notifications"
  value = module.cost_mgmt_notif.sns_topic_arn
}

# Will output the following:
# arn:aws:sns:us-east-1:111111111111:cost-mgmt-budget-notification-usd-dev

