variable "website_bucket" {
  description = "Bucket for website name"
  type = object({
    id                 = string
    bucket_domain_name = string
  })
}

variable "origin_access_identity" {
  description = "Origin access identity, which will be used to access S3 bucket"
  type = object({
    comment                         = string
    cloudfront_access_identity_path = string
  })
}

variable "project" {
  description = "Project name. Also used as a prefix in names of related resources."
  type        = string
}

variable "environment" {
  description = "Environment of the project. Also used as a prefix in names of related resources."
  type        = string
}

variable "price_class" {
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string
  default     = "PriceClass_100"
}

variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution."
  type        = list(string)
  default     = []
}

variable "default_root_object" {
  description = "The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
  type        = string
  default     = "index.html"
}

variable "error_response_path" {
  description = "The path of the custom error page (for example, /custom_404.html)."
  type        = string
  default     = "/index.html"
}

variable "forward_query_string" {
  description = "Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
  type        = bool
  default     = false
}

variable "trusted_signers" {
  description = "The AWS accounts, if any, that you want to allow to create signed URLs for private content."
  type        = list(string)
  default     = []
}

variable "min_ttl" {
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds."
  type        = number
  default     = 0
}

variable "default_ttl" {
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. Defaults to 1 day."
  type        = number
  default     = 300
}

variable "max_ttl" {
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. Defaults to 365 days."
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Optional Tags"
  type        = map(string)
  default     = {}
}

variable "acm_certificate_arn" {
  description = "The ARN of the certificate to use for the custom domain"
  type        = string
}

variable r53_hosted_zone_id {
  description = "The zone_id of the hosted zone where the DNS record for validation needs to be added"
  type        = string
  default     = null
}

variable domain {
  description = "The custom domain to use"
  type        = string
}
