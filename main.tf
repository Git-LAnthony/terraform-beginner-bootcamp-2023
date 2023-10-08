# resource "random_string" "bucket_name" {
#   lower   = true
#   upper   = false
#   length  = 32
#   special = false

# }

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    UserUuid = var.user_uuid
  }
}

