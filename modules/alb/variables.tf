variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "loadbalancer_name" {
  description = "The name of the load balancer"
  type        = string
} 

variable "loadbalancer_internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
} 

variable "loadbalancer_type" {
  description = "The type of load balancer (application or network)"
  type        = string
  default     = "application"
} 

variable "loadbalancer_subnets" {
  description = "List of public subnet IDs for the load balancer"
  type        = list(string)
}

variable "loadbalancer_enable_deletion_protection" {
  description = "Whether to enable deletion protection on the load balancer"
  type        = bool
  default     = false
}

variable "loadbalancer_listener_default_action_type" {
  description = "The default action type for listeners (e.g., 'forward')"
  type        = string
  default     = "forward"
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for ALB HTTPS listener"   
  type        = string
}

variable "environment" {
  description = "Deployment environment name (e.g., dev, staging, prod)"
  type        = string
}
