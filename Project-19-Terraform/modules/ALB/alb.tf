# ----------------------------
#External Load balancer for reverse proxy nginx
#---------------------------------

resource "aws_lb" "ext-alb" {
  name     = "ext-alb"
  internal = false
  security_groups = [
    var.public-sg,
  ]

  subnets = [
    var.public-sub-1,
    var.public-sub-2
  ]

   tags = merge(
    var.tags,
    {
      Name = "BANKYCS-ext-alb"
    },
  )

  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
}

#--- create a target group for the external load balancer
resource "aws_lb_target_group" "nginx-tgt" {
  health_check {
    interval            = var.interval
    path                = var.path
    protocol            = var.protocol
    timeout             = var.timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
  name        = "nginx-tgt"
  port        = 443
  protocol    = var.protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id
}

#--- create a listener for the load balancer

resource "aws_lb_listener" "nginx-listner" {
  load_balancer_arn = aws_lb.ext-alb.arn
  port              = 443
  protocol          = var.protocol
  certificate_arn   = aws_acm_certificate_validation.BANKYCSCert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tgt.arn
  }
}



# ----------------------------
#Internal Load Balancers for webservers
#---------------------------------

resource "aws_lb" "ialb" {
  name     = "ialb"
  internal = true
  security_groups = [
    var.private-sg
  ]

  subnets = [
    var.private-sub-1,
    var.private-sub-2
  ]

 tags = merge(
    var.tags,
    {
      Name = "BANKYCS-int-alb"
    },
  )

  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
}


# --- target group  for wordpress -------

resource "aws_lb_target_group" "wordpress-tgt" {
  health_check {
    interval            = var.interval
    path                = var.path
    protocol            = var.protocol
    timeout             = var.timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }

  name        = "wordpress-tgt"
  port        = 443
  protocol    = var.protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id
}


# --- target group for tooling -------

resource "aws_lb_target_group" "tooling-tgt" {
  health_check {
    interval            = var.interval
    path                = var.path
    protocol            = var.protocol
    timeout             = var.timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }

  name        = "tooling-tgt"
  port        = 443
  protocol    = var.protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id
}

# For this aspect a single listener was created for the wordpress which is default,
# A rule was created to route traffic to tooling when the host header changes


resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.ialb.arn
  port              = 443
  protocol          = var.protocol
  certificate_arn   = aws_acm_certificate_validation.BANKYCSCert.certificate_arn


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tgt.arn
  }
}

# listener rule for tooling target

resource "aws_lb_listener_rule" "tooling-listener" {
  listener_arn = aws_lb_listener.web-listener.arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tooling-tgt.arn
  }

  condition {
    host_header {
      values = [var.values]
    }
  }
}