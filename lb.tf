
# Create load balancer
resource "aws_lb" "main" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = toset(data.aws_subnets.list.ids)

  tags = var.common_tags
}

# Create target group
resource "aws_lb_target_group" "web_tg" {
  name_prefix = var.tg_prefix_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    path = "/"
  }

  tags = {
    Name = "web_tg"
  }
}

# Attach target group to load balancer
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# Add EC2 instances to target group
resource "aws_lb_target_group_attachment" "web_tg_attachment" {
  count            = length(aws_instance.main)
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.main[count.index].id
  port             = 80
}





