output "budget_notifications" {
  description = "% Threshold when the notification should be sent."
  value       = aws_budgets_budget.budget_notifification
}


#output "name" {
#  description = "% Threshold when the notification should be sent."
#  value       = aws_budgets_budget.budget_notifification.*.name
#}
#
#output "limit_amount" {
#  description = "Monthly billing threshold in dollars"
#  value       = aws_budgets_budget.budget_notifification.*.limit_amount
#}
#
#output "currency" {
#  description = "Billing currency eg: dollars"
#  value       = aws_budgets_budget.budget_notifification.*.limit_unit
#}
#
#output "time_period_start" {
#  description = "Time to start."
#  value       = aws_budgets_budget.budget_notifification.*.time_period_start
#}
#
#output "time_period_end" {
#  description = "Time to end."
#  value       = aws_budgets_budget.budget_notifification.*.time_period_end
#}
#
#output "time_unit" {
#  description = "The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY."
#  value       = aws_budgets_budget.budget_notifification.*.time_unit
#}
#
#output "cost_filters_service" {
#  description = "Budget service cost filter, eg: Amazon Elastic Compute Cloud - Compute / Amazon Relational Database Service / Amazon Redshift / Amazon ElastiCache/ Amazon Elasticsearch Service"
#  value       = aws_budgets_budget.budget_notifification.*.cost_filters["Service"]
#}
#
##
# SNS
#
output "sns_topic_arn" {
  description = "List of SNS Topic ARN sto be subscribed to in order to delivery the budget billing notifications"
  value       = concat([try(aws_sns_topic.sns_alert_topic[0].arn, [])], var.sns_topic_arns)
}
