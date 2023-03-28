# EC2 Instance
resource "aws_instance" "main" {
  count                       = var.instance_numbers
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.deployer.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.instance_name_prefix}-${count.index + 1}"
  })
  user_data       = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                service httpd start
                echo '<html><center><body <h1>WAF Test</h1></body></html>' > /var/www/html/index.html
                EOF
  security_groups = [aws_security_group.main.name]
}

# Create a SSH keypair
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.ec2.public_key_openssh
}

# Algorithm key
# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
resource "tls_private_key" "ec2" {
  algorithm = "RSA"
}

# Write tf-key-pair to local file
# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "tf-key" {
  content  = tls_private_key.ec2.private_key_pem
  filename = "tf-key-pair"
}
