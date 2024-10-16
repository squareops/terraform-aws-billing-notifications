# terraform-aws-billing

# AWS Budget Forecast Notification

Configuration in this directory creates set of AWS resources which may be sufficient for a fully working stage or prod
Terraform module - creates an AWS Budget with notification via SNS enabled/Email enabled with optional sns topic
creation (or use a pre-existing one) to alert when a U$S (currency actually configurable) budget forecasted threshold % is reached
(currently 100% of the `limit_amount`).

Provides an AWS budget resource (`aws_budgets_budget`). Budgets use the cost visualisation provided by **Cost Explorer** to show
you the status of your budgets, to provide forecasts of your estimated costs, and to track your AWS usage, including your free tier usage.

Please check the **input parameters** for a better understanding of it.

## Usage Example
```hcl
module "aws_budget_alert" {
  source            = "git@github.com:squareops/terraform-aws-billing.git"
  name              = local.name
  environment       = local.environment
  account_id        = local.account_id
  budget_type       = "COST"
  limit_amount      = "10"
  limit_unit        = "USD"
  time_period_start = "2023-11-16_00:00"
  time_unit         = "DAILY"
  notification = {
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
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
  slack_channel_id           = "XXXXXZZZZ"
  slack_workspace_id         = "ABCDUTSSZ"
  email_notification_enabled = true
  email_address              = "notification.com"
}

```
## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Or if using the `Makefile` in this repo you need to execute:

```bash
$ make init
$ make plan
$ make apply
```

Note that this example may create resources which can cost money (AWS EC2, for example). Run `terraform destroy` or `make destroy`
when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_awscc"></a> [awscc](#provider\_awscc) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.aws_budget_report](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |
| [aws_iam_policy.chatbot_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.chatbot_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.chatbot_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_sns_topic.aws_budget_alerts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.aws_budget_alerts_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [awscc_chatbot_slack_channel_configuration.aws_budget_alerts_slack](https://registry.terraform.io/providers/hashicorp/awscc/latest/docs/resources/chatbot_slack_channel_configuration) | resource |
| [aws_iam_policy_document.aws_budgets_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.chatbot_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_slack_notification_enabled"></a> [slack\_notification\_enabled](#input\_slack\_notification\_enabled) | Flag to enable or disable Slack notifications. | `bool` | `false` | no |
| <a name="input_slack_channel_id"></a> [slack\_channel\_id](#input\_slack\_channel\_id) | The ID of the Slack channel for notifications. | `string` | `""` | no |
| <a name="input_slack_workspace_id"></a> [slack\_workspace\_id](#input\_slack\_workspace\_id) | The ID of the Slack workspace for notifications. | `string` | `""` | no |
| <a name="input_notification"></a> [notification](#input\_notification) | Configuration for budget notifications. | <pre>object({<br>    comparison_operator = optional(string, "GREATER_THAN") # LESS_THAN, EQUAL_TO or GREATER_THAN<br>    threshold           = number<br>    threshold_type      = string                     # PERCENTAGE or ABSOLUTE_VALUE<br>    notification_type   = optional(string, "ACTUAL") # ACTUAL or FORECASTED<br>  })</pre> | n/a | yes |
| <a name="input_cost_types"></a> [cost\_types](#input\_cost\_types) | Configuration for included cost types in the budget. | `any` | <pre>{<br>  "include_credit": false,<br>  "include_discount": true,<br>  "include_other_subscription": true,<br>  "include_recurring": true,<br>  "include_refund": false,<br>  "include_subscription": true,<br>  "include_support": true,<br>  "include_tax": true,<br>  "include_upfront": true,<br>  "use_blended": false<br>}</pre> | no |
| <a name="input_time_period_start"></a> [time\_period\_start](#input\_time\_period\_start) | The start date of the budget time period(e.g., 2017-01-01\_12:00). | `string` | `""` | no |
| <a name="input_time_period_end"></a> [time\_period\_end](#input\_time\_period\_end) | The start date of the budget time period(e.g., 2017-01-01\_12:00). | `string` | `""` | no |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | The unit of time for the budget (e.g., MONTHLY, QUARTERLY, ANNUALLY and DAILY). | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | A unique name for the budget configuration. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for which the budget is configured. | `string` | `""` | no |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The AWS account ID for which the budget is created. | `string` | `""` | no |
| <a name="input_budget_type"></a> [budget\_type](#input\_budget\_type) | The type of budget (e.g., COST, USAGE) for monitoring. | `string` | `""` | no |
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | The budgeted amount for the specified time period. | `number` | n/a | yes |
| <a name="input_limit_unit"></a> [limit\_unit](#input\_limit\_unit) | The unit of measurement for the budgeted amount(e.g,, USD, GB). | `string` | `""` | no |
| <a name="input_email_notification_enabled"></a> [email\_notification\_enabled](#input\_email\_notification\_enabled) | Flag to enable or disable Slack notifications. | `bool` | `false` | no |
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | The Amazon Resource Name (ARN) of the created AWS SNS topic for budget alerts. |
| <a name="output_budget_report_id"></a> [budget\_report\_id](#output\_budget\_report\_id) | The ID of the AWS Budgets budget report created for monitoring costs. |
| <a name="output_chatbot_role_arn"></a> [chatbot\_role\_arn](#output\_chatbot\_role\_arn) | The ARN of the AWS IAM role created for the chatbot to assume. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribution & Issue Reporting

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/sq-ia/terraform-aws-billing/issues) on GitHub
  2. Search to see if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Be sure to provide enough context and details so others can understand your problem.

## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/).

## Support Us

To support a GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the [GitHub repository](https://github.com/sq-ia/terraform-aws-billing).

  2. Click the "Star" button: On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Starring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 4 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

To find more information about our company, visit [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).
