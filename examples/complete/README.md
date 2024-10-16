# AWS Budget Forecast Notification

Configuration in this directory creates set of AWS resources which may be sufficient for a fully working stage or prod
Terraform module - creates an AWS Budget with notification via SNS enabled with optional sns topic
creation (or use a pre-existing one) to alert when a U$S (currency actually configurable) budget forecasted threshold % is reached
(currently 100% of the `limit_amount`).

Provides an AWS budget resource (`aws_budgets_budget`). Budgets use the cost visualisation provided by **Cost Explorer** to show
you the status of your budgets, to provide forecasts of your estimated costs, and to track your AWS usage, including your free tier usage.

Please check the **input parameters** for a better understanding of it.

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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_budget_alert"></a> [aws\_budget\_alert](#module\_aws\_budget\_alert) | git@github.com:squareops/terraform-aws-billing.git | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | The Amazon Resource Name (ARN) of the created AWS SNS topic for budget alerts. |
| <a name="output_budget_report_id"></a> [budget\_report\_id](#output\_budget\_report\_id) | The ID of the AWS Budgets budget report created for monitoring costs. |
| <a name="output_chatbot_role_arn"></a> [chatbot\_role\_arn](#output\_chatbot\_role\_arn) | The ARN of the AWS IAM role created for the chatbot to assume. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
