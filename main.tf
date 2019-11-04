terraform {
  required_version = ">= 0.12"
}

locals {
  tags = merge(
    {
      project     = var.project
      environment = var.environment
    },
    var.tags
  )
}

# Create a Cloudfront distribution for the static website

resource "aws_cloudfront_distribution" "website_cdn" {
  enabled      = true
  price_class  = var.price_class
  http_version = "http2"

  origin {
    domain_name = var.website_bucket.bucket_domain_name
    origin_id   = var.origin_access_identity.comment

    s3_origin_config {
      origin_access_identity = var.origin_access_identity.cloudfront_access_identity_path
    }
  }

  default_root_object = var.default_root_object

  dynamic "custom_error_response" {
    for_each = [403, 404]
    content {
      error_code            = custom_error_response.value
      error_caching_min_ttl = 360
      response_code         = 200
      response_page_path    = var.error_response_path
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "DELETE", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = var.forward_query_string

      cookies {
        forward = "none"
      }
    }

    trusted_signers = var.trusted_signers

    min_ttl          = var.min_ttl
    default_ttl      = var.default_ttl
    max_ttl          = var.max_ttl
    target_origin_id = var.origin_access_identity.comment

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  aliases = var.aliases
  comment = var.domain

  tags = merge({ Name = var.website_bucket.id }, local.tags)
}

# Create A record for distribution

resource "aws_route53_record" "domain" {
  count = var.r53_hosted_zone_id != null ? 1 : 0

  zone_id = var.r53_hosted_zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.website_cdn.hosted_zone_id
    evaluate_target_health = true
  }
}
