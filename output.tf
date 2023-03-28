output "lb_dns" {
  value = "http://${aws_lb.main.dns_name}"
}
