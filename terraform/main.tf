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

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

####################################
# S3 Bucket - Single shared bucket
####################################

resource "aws_s3_bucket" "herb_images" {
  bucket = "herbal-herb-images"

  tags = {
    Name    = "herbal-herb-images"
    Purpose = "Herb reference images - shared across all environments"
  }
}

resource "aws_s3_bucket_public_access_block" "herb_images" {
  bucket                  = aws_s3_bucket.herb_images.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "herb_images" {
  bucket     = aws_s3_bucket.herb_images.id
  depends_on = [aws_s3_bucket_public_access_block.herb_images]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "PublicReadGetObject"
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.herb_images.arn}/*"
    }]
  })
}

resource "aws_s3_bucket_cors_configuration" "herb_images" {
  bucket = aws_s3_bucket.herb_images.id

  cors_rule {
    allowed_headers = ["Content-Type"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = [
      "http://localhost:3000",
      "https://herbal-visualizer.vercel.app",
      "https://apothetracker.com",
      "https://www.apothetracker.com",
    ]
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
        Sid      = "S3HerbImages"
        Effect   = "Allow"
        Action   = ["s3:PutObject", "s3:DeleteObject"]
        Resource = "${aws_s3_bucket.herb_images.arn}/*"
      }
    ]
  })
}

####################################
# Outputs
####################################

output "bucket_name" {
  value = aws_s3_bucket.herb_images.bucket
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
    Add these to .env.local (same values for all environments):

      AWS_REGION=${var.aws_region}
      AWS_ACCESS_KEY_ID=<run: terraform output -raw iam_access_key_id>
      AWS_SECRET_ACCESS_KEY=<run: terraform output -raw iam_secret_access_key>
      AWS_S3_BUCKET=herbal-herb-images

    Then run the migration:
      supabase/migrations/161_herb_image_url.sql
  EOT
}
