resource "aws_lb" "backend" {
  name               = "${var.environment}-backend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.alb_config.public_subnet_ids


#   enable_deletion_protection = true ----------------------for real world cases it should be enabled

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "backend" {
  name = "${var.environment}-backend-tg"
  port =80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
  
}