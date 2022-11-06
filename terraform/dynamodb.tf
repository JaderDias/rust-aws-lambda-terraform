resource "aws_dynamodb_table" "site_table" {
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "DomainAndPath"
  name             = "${terraform.workspace}_site_${random_pet.one.id}_${random_pet.two.id}"
  range_key        = "LanguageBcp47"
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"
  table_class      = "STANDARD"

  attribute {
    name = "DomainAndPath"
    type = "S"
  }

  attribute {
    name = "LanguageBcp47"
    type = "S"
  }

  attribute {
    name = "IsEdited"
    type = "N"
  }

  global_secondary_index {
    name            = "IsEditedIndex"
    hash_key        = "IsEdited"
    projection_type = "ALL"
  }

  tags = {
    environment = terraform.workspace,
    deployment  = "${random_pet.one.id}_${random_pet.two.id}",
  }
}
