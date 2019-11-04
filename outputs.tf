output "website_cdn" {
  value = aws_cloudfront_distribution.website_cdn
}

output "domain" {
  value = aws_route53_record.domain
}
