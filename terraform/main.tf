####################################
# Terraform & Provider Configuration
####################################
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-west-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "default"
}

variable "dev_allowed_origins" {
  description = "Origins allowed to PUT to the dev bucket (CORS)"
  type        = list(string)
  default     = ["http://localhost:3000"]
}

variable "prod_allowed_origins" {
  description = "Origins allowed to PUT to the prod bucket (CORS)"
  type        = list(string)
  default     = ["https://apothetracker.com", "https://www.apothetracker.com"]
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

####################################
# S3 Buckets - Dev & Prod
####################################

locals {
  buckets = {
    dev  = "herbal-herb-images-dev"
    prod = "herbal-herb-images-prod"
  }
}

resource "aws_s3_bucket" "herb_images_dev" {
  bucket = local.buckets.dev

  tags = {
    Name        = local.buckets.dev
    Environment = "dev"
    Purpose     = "Herb reference images - development"
  }
}

resource "aws_s3_bucket" "herb_images_prod" {
  bucket = local.buckets.prod

  tags = {
    Name        = local.buckets.prod
    Environment = "prod"
    Purpose     = "Herb reference images - production"
  }
}

# Block ACL-based public access; objects are readable via bucket policy below
resource "aws_s3_bucket_public_access_block" "herb_images_dev" {
  bucket                  = aws_s3_bucket.herb_images_dev.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_public_access_block" "herb_images_prod" {
  bucket                  = aws_s3_bucket.herb_images_prod.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

# Public-read policy — herb images are intentionally public
resource "aws_s3_bucket_policy" "herb_images_dev" {
  bucket     = aws_s3_bucket.herb_images_dev.id
  depends_on = [aws_s3_bucket_public_access_block.herb_images_dev]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "PublicReadGetObject"
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.herb_images_dev.arn}/*"
    }]
  })
}

resource "aws_s3_bucket_policy" "herb_images_prod" {
  bucket     = aws_s3_bucket.herb_images_prod.id
  depends_on = [aws_s3_bucket_public_access_block.herb_images_prod]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "PublicReadGetObject"
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.herb_images_prod.arn}/*"
    }]
  })
}

# CORS — allow browser presigned PUT uploads from the app
resource "aws_s3_bucket_cors_configuration" "herb_images_dev" {
  bucket = aws_s3_bucket.herb_images_dev.id

  cors_rule {
    allowed_headers = ["Content-Type"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = var.dev_allowed_origins
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_cors_configuration" "herb_images_prod" {
  count  = length(var.prod_allowed_origins) > 0 ? 1 : 0
  bucket = aws_s3_bucket.herb_images_prod.id

  cors_rule {
    allowed_headers = ["Content-Type"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = var.prod_allowed_origins
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

####################################
# IAM User - Next.js App
####################################

resource "aws_iam_user" "herbal_nextjs" {
  name = "herbal-visualizer-nextjs"

  tags = {
    Name    = "herbal-visualizer-nextjs"
    Purpose = "Next.js app S3 herb image uploads"
  }
}

resource "aws_iam_access_key" "herbal_nextjs" {
  user = aws_iam_user.herbal_nextjs.name
}

resource "aws_iam_user_policy" "herbal_nextjs" {
  name = "herbal-visualizer-nextjs-policy"
  user = aws_iam_user.herbal_nextjs.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3HerbImagesBothEnvs"
        Effect = "Allow"
        Action = ["s3:PutObject", "s3:DeleteObject"]
        Resource = [
          "${aws_s3_bucket.herb_images_dev.arn}/*",
          "${aws_s3_bucket.herb_images_prod.arn}/*",
        ]
      }
    ]
  })
}

####################################
# Outputs
####################################

output "dev_bucket_name" {
  value = aws_s3_bucket.herb_images_dev.bucket
}

output "prod_bucket_name" {
  value = aws_s3_bucket.herb_images_prod.bucket
}

output "region" {
  value = var.aws_region
}

output "iam_access_key_id" {
  value     = aws_iam_access_key.herbal_nextjs.id
  sensitive = true
}

output "iam_secret_access_key" {
  value     = aws_iam_access_key.herbal_nextjs.secret
  sensitive = true
}

output "setup_instructions" {
  value = <<-EOT
    Add these to .env.local:

      AWS_REGION=${var.aws_region}
      AWS_ACCESS_KEY_ID=<run: terraform output -raw iam_access_key_id>
      AWS_SECRET_ACCESS_KEY=<run: terraform output -raw iam_secret_access_key>
      AWS_S3_BUCKET=${local.buckets.dev}   # or ${local.buckets.prod} in production

    Then run the migration:
      supabase/migrations/161_herb_image_url.sql
  EOT
}
