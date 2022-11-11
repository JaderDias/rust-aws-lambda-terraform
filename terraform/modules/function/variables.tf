variable "architecture" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "function_name" {
  type = string
}
variable "lambda_handler" {
  type = string
}
variable "schedule_expression" {
  type    = string
  default = null
}
variable "source_dir" {
  type = string
}
variable "tags" {
  description = "tags for lambda function"
  type        = map(string)
}
