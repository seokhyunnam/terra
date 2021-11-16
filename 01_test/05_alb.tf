resource "aws_lb" "shnam_alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.shnam_sg.id]
  subnets            = [aws_subnet.shnam_pub[0].id, aws_subnet.shnam_pub[1].id]

  tags = {
    "Name" = "${var.name}-alb"
  }
}

output "alb_dns" {
  value = aws_lb.shnam_alb.dns_name
}

resource "aws_lb_target_group" "shnam_albtg" {
  name     = "${var.name}-albtg"
  port     = var.port_http
  protocol = var.protocol_http1
  vpc_id   = aws_vpc.shnam_vpc.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 5
    matcher             = "200"
    path                = "/health.html"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "shnam_albli" {
  load_balancer_arn = aws_lb.shnam_alb.arn
  port              = var.port_http
  protocol          = var.protocol_http1

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.shnam_albtg.arn
  }
}

resource "aws_lb_target_group_attachment" "shnam_tgatt" {
  target_group_arn = aws_lb_target_group.shnam_albtg.arn
  target_id        = aws_instance.shnam_web.id
  port             = var.port_http
}
