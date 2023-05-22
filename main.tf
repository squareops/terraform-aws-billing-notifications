locals {

  budget = {

    name              = var.cost_filters_service == null ? "budget-${var.time_unit}-${var.environment}" : "budget-${var.cost_filters_service}-${var.time_unit}-${var.environment}"
    budget_type       = "COST"
    limit_amount      = var.limit_amount
    limit_unit        = var.currency
    time_unit         = var.time_unit
    time_period_start = var.time_period_start
    time_period_end   = var.time_period_end
    
  }

  notification = {
    comparison_operator = "GREATER_THAN"
    threshold           = var.notification_threshold
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_sns_topic_arns = concat(
      compact(
        [try(aws_sns_topic.sns_alert_topic[0].arn, null)]
      ),
      var.sns_topic_arns
    )
  }

  cost_types = {
    # A boolean value whether to include credits in the cost budget.
    include_credit = false

    # Specifies whether a budget includes discounts. Defaults to
    include_discount = true

    # A boolean value whether to include other subscription costs in the cost budget.
    include_other_subscription = true

    # A boolean value whether to include recurring costs in the cost budget.
    include_recurring = true

    # A boolean value whether to include refunds in the cost budget.
    include_refund = false

    # A boolean value whether to include subscriptions in the cost budget.
    include_subscription = true

    # A boolean value whether to include support costs in the cost budget.
    include_support = true

    # A boolean value whether to include support costs in the cost budget.
    include_tax = true

    # A boolean value whether to include support costs in the cost budget.
    include_upfront = true

    # Specifies whether a budget uses the amortized rate.
    use_amortized = false

    # A boolean value whether to use blended costs in the cost budget.
    use_blended = false
  }
}

# Budget
resource "aws_budgets_budget" "budget_notifification" {

  name              = lookup(local.budget, "name")
  budget_type       = lookup(local.budget, "budget_type")
  limit_unit        = lookup(local.budget, "limit_unit")
  limit_amount      = lookup(local.budget, "limit_amount")
  time_unit         = lookup(local.budget, "time_unit")
  time_period_start = lookup(local.budget, "time_period_start")
  time_period_end   = lookup(local.budget, "time_period_end")
  

  cost_filters = {
    Service = var.cost_filters_service
  }

  notification {
    threshold                 = lookup(local.notification, "threshold")
    threshold_type            = lookup(local.notification, "threshold_type")
    notification_type         = lookup(local.notification, "notification_type")
    comparison_operator       = lookup(local.notification, "comparison_operator")
    subscriber_sns_topic_arns = lookup(local.notification, "subscriber_sns_topic_arns")
  }

  cost_types {
    include_tax                = lookup(local.cost_types, "include_tax")
    include_credit             = lookup(local.cost_types, "include_credit")
    include_refund             = lookup(local.cost_types, "include_refund")
    include_upfront            = lookup(local.cost_types, "include_upfront")
    include_support            = lookup(local.cost_types, "include_support")
    include_discount           = lookup(local.cost_types, "include_discount")
    include_recurring          = lookup(local.cost_types, "include_recurring")
    include_subscription       = lookup(local.cost_types, "include_subscription")
    include_other_subscription = lookup(local.cost_types, "include_other_subscription")
    use_amortized              = lookup(local.cost_types, "use_amortized")
    use_blended                = lookup(local.cost_types, "use_blended")
  }
}

