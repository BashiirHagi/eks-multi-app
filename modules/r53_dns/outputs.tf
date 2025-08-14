output "tm_record_fqdn" {
  value = aws_route53_record.tm_subdomain_alias.fqdn
}