provider "aws" {
  region = "eu-west-2"
  shared_config_files = [ "/Users/adnanhussain/.aws/config" ]
  shared_credentials_files = [ "/Users/adnanhussain/.aws/credentials" ]
  profile = "adnan-aws"
}

# creates a dynamodb table called visit count (this is set to PROVISIONED by default)
# hash key = parition key which i've assigned the value "id" to
# set a read/write capacity
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

# added an item within the table i've created above
# the id = cloud-resume-website. i will refer to this id later when adding the visit count
# visits = 0. this number will increase once i've created the visit count logic
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