output dns_alb {
  value       = aws_lb.ecs_alb.dns_name
  description = "Output variable for the ALB DNS"
}
