resource "aws_s3_bucket" "bucket" {
  bucket = "${terraform.workspace}-bucket-${random_pet.one.id}-${random_pet.two.id}"

  tags = {
    environment = terraform.workspace
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}
