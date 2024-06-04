resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_website_configuration" "s3_host_config" {
  bucket = aws_s3_bucket.s3.id
  index_document {
    suffix = var.website_suffix
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  bucket = aws_s3_bucket.s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.ownership_controls]
  bucket     = aws_s3_bucket.s3.id
  acl        = "private"
}

locals {
  content_type_map = {
    "js"   = "application/javascript"
    "html" = "text/html"
    "css"  = "text/css"
    "svg"  = "image/svg+xml"
  }
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.s3.bucket

  for_each = fileset("../client/build/", "**/*.*")

  key    = each.value
  source = "../client/build/${each.value}"
  etag   = filemd5("../client/build/${each.value}")

  content_type = lookup(local.content_type_map, reverse(split(".", each.value))[0], "binary/octet-stream")
}

resource "aws_s3_bucket_cors_configuration" "name" {
  bucket = aws_s3_bucket.s3.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD", "POST", "PUT", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}
