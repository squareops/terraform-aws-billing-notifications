variable "slack_notification_enabled" {
  description = "Flag to enable or disable Slack notifications."
  type        = bool
  default     = false
}

variable "slack_channel_id" {
  description = "The ID of the Slack channel for notifications."
  type        = string
  default     = ""
}

variable "slack_workspace_id" {
  description = "The ID of the Slack workspace for notifications."
  type        = string
  default     = ""
}

variable "notification" {
  description = "Configuration for budget notifications."
  type = object({
    comparison_operator = optional(string, "GREATER_THAN") # LESS_THAN, EQUAL_TO or GREATER_THAN
    threshold           = number
    threshold_type      = string                     # PERCENTAGE or ABSOLUTE_VALUE
    notification_type   = optional(string, "ACTUAL") # ACTUAL or FORECASTED
  })
}

variable "cost_types" {
  description = "Configuration for included cost types in the budget."
  default = {
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
  type = any
}

variable "time_period_start" {
  description = "The start date of the budget time period(e.g., 2017-01-01_12:00)."
  type        = string
  default     = ""
}

variable "time_period_end" {
  description = "The start date of the budget time period(e.g., 2017-01-01_12:00)."
  type        = string
  default     = ""
}

variable "time_unit" {
  description = "The unit of time for the budget (e.g., MONTHLY, QUARTERLY, ANNUALLY and DAILY)."
  type        = string
  default     = ""
}

variable "name" {
  description = "A unique name for the budget configuration."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment for which the budget is configured."
  type        = string
  default     = ""
}

variable "account_id" {
  description = "The AWS account ID for which the budget is created."
  type        = string
  default     = ""
}

variable "budget_type" {
  description = "The type of budget (e.g., COST, USAGE) for monitoring."
  type        = string
  default     = ""
}

variable "limit_amount" {
  description = "The budgeted amount for the specified time period."
  type        = number
}

variable "limit_unit" {
  description = "The unit of measurement for the budgeted amount(e.g,, USD, GB)."
  type        = string
  default     = ""
}

variable "email_notification_enabled" {
  description = "Flag to enable or disable Slack notifications."
  type        = bool
  default     = false
}

variable "email_address" {
  type    = string
  default = ""
}

#=================
# variable "email_address" {
#   type = string
#   default = "rohit.kumar@squareops.com"
# }

# variable "slack_channel_id" {
#   type = string
#   default = "C0638MUDWUD"
# }

# variable "slack_workspace_id" {
#   type = string
#   default = "TB5FXBSUE"
# }

# variable "aws_account_id" {
#   type = string
#   default = "271251951598"
# }

# variable "threshold" {
#   type = string
#   default = "100"
# }

# variable "limit_amount" {
#   type = string
#   default = "10"
# }
