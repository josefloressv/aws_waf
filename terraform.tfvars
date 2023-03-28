common_tags          = { Environment = "dev", AppName = "GoWeb" }
instance_type        = "t2.micro"
instance_name_prefix = "web"
instance_numbers     = 2
sg_name              = "goweb-terraform-ec2-only"
sg_description       = "EC2 bastion SGs"

sg_inbound_rules = [
  {
    description = "WWW from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  /*  {
    description = "TLS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }, */
  {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

lb_name        = "web-lb"
tg_prefix_name = "web-tg"

web_acl_name = "web-acl"