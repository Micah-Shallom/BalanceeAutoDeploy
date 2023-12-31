###################################################################################
# ----------------------------
#External Load Balancers for webservers
#---------------------------------
####################################################################################
resource "aws_lb" "ext-alb" {
  name     = var.name1
  internal = false
  security_groups = [
    var.public-sg
  ]

  subnets = [
    var.public-sbn-1,
    var.public-sbn-2
  ]

  tags = merge(
    var.tags,
    {
      Name = var.name1
    },
  )

  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
}

#-------- Creating the nginx target group -------------
resource "aws_lb_target_group" "nginx-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "nginx-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "nginx-listner" {
  load_balancer_arn = aws_lb.ext-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.shallom.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tgt.arn
  }
}

###################################################################################
# ----------------------------
#Internal Load Balancers for webservers
#---------------------------------
####################################################################################
resource "aws_lb" "int-alb" {
  name     = var.name2
  internal = true
  security_groups = [
    var.private-sg
  ]

  subnets = [
    var.private-sbn-1,
    var.private-sbn-2
  ]

  tags = merge(
    var.tags,
    {
      Name = "RCR-int-alb"
    },
  )

  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
}

# --- target group  for application -------

resource "aws_lb_target_group" "application-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "application-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

# For this aspect a single listener was created for the application is default

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.int-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.shallom.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application-tgt.arn
  }
}
