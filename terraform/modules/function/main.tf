data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${var.source_dir}.zip"
}

resource "aws_lambda_function" "myfunc" {
  architectures    = [var.architecture]
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.function_name
  handler          = var.lambda_handler
  memory_size      = 128 // it uses only 20 MiB because it saves the file to disk
  role             = aws_iam_role.iam_for_terraform_lambda.arn
  runtime          = "provided.al2"
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  tags             = var.tags
  timeout          = 900 // with 8 goroutines in parallel we can parse 1000 warcs in 2.5 minutes
  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }

  # Explicitly declare dependency on EFS mount target.
  # When creating or updating Lambda functions, mount target must be in 'available' lifecycle state.
  depends_on = [
    aws_cloudwatch_log_group.lambda_log_group,
    data.archive_file.lambda_zip,
  ]
}
