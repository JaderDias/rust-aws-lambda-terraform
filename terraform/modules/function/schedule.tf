resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  count               = var.schedule_expression == null ? 0 : 1
  name                = "cloudwatch_event_rule"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  count     = var.schedule_expression == null ? 0 : 1
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule[0].name
  target_id = "lambda"
  arn       = aws_lambda_function.myfunc.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  count         = var.schedule_expression == null ? 0 : 1
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.myfunc.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_event_rule[0].arn
}
