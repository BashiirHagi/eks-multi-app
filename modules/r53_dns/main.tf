resource "aws_route53_record" "tm_subdomain_alias" { //R53 a_record
  zone_id = var.hosted_zone_id
  name    = "tm.techwithbashiir.com" // domain-IPV4 
  type    = "A" 

  alias {
    name                   = var.alb_dns //pointing to ALB DNS name
    zone_id                = var.alb_zone_id 
    evaluate_target_health = true 
  }
}