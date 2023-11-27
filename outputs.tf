output "sns_topic_arn" {
  description = "The Amazon Resource Name (ARN) of the created AWS SNS topic for budget alerts."
  value       = aws_sns_topic.aws_budget_alerts.arn
}

output "budget_report_id" {
  description = "The ID of the AWS Budgets budget report created for monitoring costs."
  value       = aws_budgets_budget.aws_budget_report.id
}

output "chatbot_role_arn" {
  description = "The ARN of the AWS IAM role created for the chatbot to assume."
  value       = aws_iam_role.chatbot_role.arn
}
