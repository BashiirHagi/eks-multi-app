
variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}

variable "alb_dns" {
  description = "ALB DNS name to point to"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB hosted zone ID"
  type        = string
}

