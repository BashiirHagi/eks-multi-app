resource "aws_lb" "load_balancer" { //load balancer resource
  name                       = var.loadbalancer_name
  internal                   = var.loadbalancer_internal
  load_balancer_type         = var.loadbalancer_type
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = var.loadbalancer_subnets
  enable_deletion_protection = var.loadbalancer_enable_deletion_protection

  tags = {
    Name = "${var.environment}-lb"
  }
}

//SG
resource "aws_security_group" "alb_sg" {  //security group for the ALB
  name        = "${var.environment}-alb-sg"
  description = "Allow HTTP traffic to the ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic" //all protocls and all hosts allowed
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-alb-sg"
  }
}


#########load-balancers listeners#######
resource "aws_lb_listener" "http_listener" {  //listens for HTTP traffic on port 80
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = var.loadbalancer_listener_default_action_type
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
  tags = {
    Name = "${var.environment}-http-listener"
  }
}

resource "aws_lb_target_group" "ecs_tg" { //target group for ECS tasks
  name        = "ecs-alb-tg"
  target_type = "ip"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "https_listener" {  //listens for HTTPS traffic on ALB on port 443
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn //SSL cert

  default_action {
    type             = var.loadbalancer_listener_default_action_type
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
  tags = {
    Name = "${var.environment}-https-listener"
  }
}