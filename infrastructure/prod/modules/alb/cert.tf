# Create the certificate using a wildcard for all the domains created in shallom.tk
resource "aws_acm_certificate" "shallom" {
  domain_name       = "*.mshallom.click"
  validation_method = "DNS"
}

# calling the hosted zone
data "aws_route53_zone" "shallom" {
  name         = "mshallom.click"
  private_zone = false
}

# selecting validation method
resource "aws_route53_record" "shallom" {
  for_each = {
    for dvo in aws_acm_certificate.shallom.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.shallom.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "shallom" {
  certificate_arn         = aws_acm_certificate.shallom.arn
  validation_record_fqdns = [for record in aws_route53_record.shallom : record.fqdn]
}

# create records for tooling
resource "aws_route53_record" "application" {
  zone_id = data.aws_route53_zone.shallom.zone_id
  name    = "balancee.mshallom.click"
  type    = "A"
  
  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}
