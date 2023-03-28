# Create Web ACL
resource "aws_wafv2_web_acl" "main" {
  name        = var.web_acl_name
  description = "Web ACL for blocking IPs"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "block_ip_set"
    priority = 1
    action {
      block {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.blocked_ips.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "rule-1-metric-name"
      sampled_requests_enabled   = false
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "acl-general-metrics"
    sampled_requests_enabled   = false
  }
  tags = var.common_tags
}

# Attach Web ACL to Application Load Balancer
resource "aws_wafv2_web_acl_association" "web_acl_assoc" {
  resource_arn = aws_lb.main.arn
  web_acl_arn  = aws_wafv2_web_acl.main.arn
}

# Create IP set for blocked IPs
resource "aws_wafv2_ip_set" "blocked_ips" {
  name               = "blocked_ips"
  ip_address_version = "IPV4"
  scope              = "REGIONAL"
  addresses = [
    "10.0.0.1/32",
    "192.168.1.1/32",
    "190.62.19.208/32"
  ]

  tags = var.common_tags
}
