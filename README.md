# AWS Cloudfront module

[Inspired by this module](https://github.com/ringods/terraform-website-s3-cloudfront-route53), but split up in different modules and added various security and other settings (e.g. encryption, access logging, versioning, ...).

This module will configure a specific Clourfront distribution that serves static content from an S3 bucket, and APIs from API Gateway.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acm\_certificate\_arn | The ARN of the certificate to use for the custom domain | string | n/a | yes |
| aliases | Extra CNAMEs (alternate domain names), if any, for this distribution. | list(string) | `[]` | no |
| default\_root\_object | The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. | string | `"index.html"` | no |
| default\_ttl | The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. Defaults to 1 day. | number | `"300"` | no |
| environment | Environment of the project. Also used as a prefix in names of related resources. | string | n/a | yes |
| error\_response\_path | The path of the custom error page (for example, /custom_404.html). | string | `"/index.html"` | no |
| forward\_query\_string | Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior. | bool | `"false"` | no |
| max\_ttl | The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. Defaults to 365 days. | number | `"3600"` | no |
| min\_ttl | The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds. | number | `"0"` | no |
| origin\_access\_identity | Origin access identity, which will be used to access S3 bucket | object | n/a | yes |
| price\_class | The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100 | string | `"PriceClass_100"` | no |
| project | Project name. Also used as a prefix in names of related resources. | string | n/a | yes |
| tags | Optional Tags | map(string) | `{}` | no |
| trusted\_signers | The AWS accounts, if any, that you want to allow to create signed URLs for private content. | list(string) | `[]` | no |
| website\_bucket | Bucket for website name | object | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| website\_cdn |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
