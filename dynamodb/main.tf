provider "aws" {
  region = "eu-west-2"
  shared_config_files = [ "/Users/adnanhussain/.aws/config" ]
  shared_credentials_files = [ "/Users/adnanhussain/.aws/credentials" ]
  profile = "adnan-aws"
}

resource "aws_dynamodb_table" "dynamodb" {
  name = "visit-count"
  hash_key = "id"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "example" {
  table_name = aws_dynamodb_table.dynamodb.name
  hash_key   = aws_dynamodb_table.dynamodb.hash_key

  item = <<ITEM
{
  "id": {"S": "cloud-resume-website"},
  "visits": {"N": "0"}
}
ITEM
}