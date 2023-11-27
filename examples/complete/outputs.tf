output "sns_topic_arn" {
  description = "The Amazon Resource Name (ARN) of the created AWS SNS topic for budget alerts."
  value       = module.aws_budget_alert.sns_topic_arn
}

output "budget_report_id" {
  description = "The ID of the AWS Budgets budget report created for monitoring costs."
  value       = module.aws_budget_alert.budget_report_id
}

output "chatbot_role_arn" {
  description = "The ARN of the AWS IAM role created for the chatbot to assume."
  value       = module.aws_budget_alert.chatbot_role_arn
}