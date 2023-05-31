output "budget_notifications" {
  description = "% Threshold when the notification should be sent."
  value       = aws_budgets_budget.budget_notifification
}

output "sns_topic_arn" {
  description = "List of SNS Topic ARN sto be subscribed to in order to delivery the budget billing notifications"
  value       = concat([try(aws_sns_topic.sns_alert_topic[0].arn, [])], var.sns_topic_arns)
}
