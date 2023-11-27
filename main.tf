resource "aws_sns_topic" "aws_budget_alerts" {
  name = "${var.account_id}-aws-budget-alerts"
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn    = aws_sns_topic.aws_budget_alerts.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "aws_budget_alerts_target" {
  count     = var.email_notification_enabled ? 1 : 0
  topic_arn = aws_sns_topic.aws_budget_alerts.arn
  protocol  = "email"
  endpoint  = var.email_address
}

resource "aws_budgets_budget" "aws_budget_report" {
  name         = format("%s-%s-%s-report", var.environment, var.name, var.time_unit)
  budget_type  = var.budget_type
  limit_amount = var.limit_amount
  limit_unit   = var.limit_unit
  time_unit    = var.time_unit

  notification {
    comparison_operator       = var.notification.comparison_operator
    threshold                 = var.notification.threshold
    threshold_type            = var.notification.threshold_type
    notification_type         = var.notification.notification_type
    subscriber_sns_topic_arns = [aws_sns_topic.aws_budget_alerts.arn]
  }

  cost_types {
    include_credit             = var.cost_types.include_credit
    include_discount           = var.cost_types.include_discount
    include_other_subscription = var.cost_types.include_other_subscription
    include_recurring          = var.cost_types.include_recurring
    include_refund             = var.cost_types.include_refund
    include_subscription       = var.cost_types.include_subscription
    include_support            = var.cost_types.include_support
    include_tax                = var.cost_types.include_tax
    include_upfront            = var.cost_types.include_upfront
    use_blended                = var.cost_types.use_blended
  }
}

resource "aws_iam_policy" "chatbot_role_policy" {
  name   = format("%s-%s-chatbot-policy", var.environment, var.name)
  policy = data.aws_iam_policy_document.chatbot_policy.json
}

resource "aws_iam_role" "chatbot_role" {
  name               = format("%s-%s-chatbot-role", var.environment, var.name)
  assume_role_policy = data.aws_iam_policy_document.aws_budgets_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "chatbot_policy_attach" {
  role       = aws_iam_role.chatbot_role.name
  policy_arn = aws_iam_policy.chatbot_role_policy.arn
}

resource "awscc_chatbot_slack_channel_configuration" "aws_budget_alerts_slack" {
  count              = var.slack_notification_enabled ? 1 : 0
  configuration_name = format("%s-%s-%s-cost",var.environment,var.name,var.time_unit)
  iam_role_arn       = aws_iam_role.chatbot_role.arn
  slack_channel_id   = var.slack_channel_id
  slack_workspace_id = var.slack_workspace_id
  sns_topic_arns     = [aws_sns_topic.aws_budget_alerts.arn]
}
