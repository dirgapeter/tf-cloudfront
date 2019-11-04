terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

provider "aws" {
  region = "us-east-1"
  alias  = "cert-us-east-1"
}

data "aws_route53_zone" "domain" {
  name = local.main_domain
}

data "aws_acm_certificate" "domain_cert" {
  domain   = local.main_domain
  statuses = ["ISSUED"]
  provider = aws.cert-us-east-1
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  name_lower  = lower(random_string.suffix.result)
  main_domain = "dev.example.com"
  sub_domain  = replace(local.main_domain, "dev", "example-${local.name_lower}")

  tags = {
    example = "true"
  }
}

module "s3_static_web" {
  source = "git::git@github.com:dirgapeter/tf-static-web.git?ref=0.0.1"

  bucket_name = local.name_lower

  project     = var.project
  environment = var.environment

  tags = local.tags
}

module "cloudfront" {
  source = "../../"

  project     = var.project
  environment = var.environment

  website_bucket         = module.s3_static_web.website_bucket
  origin_access_identity = module.s3_static_web.origin_access_identity

  # Important for angular apps if they use routing mechanism
  error_response_path = "/index.html"

  acm_certificate_arn = data.aws_acm_certificate.domain_cert.arn
  aliases             = [local.main_domain]
  domain              = local.main_domain
  r53_hosted_zone_id  = data.aws_route53_zone.domain.zone_id

  tags = local.tags
}
