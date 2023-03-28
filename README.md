# AWS WAF sample

## Deploy infrastructure app
```bash
terraform init
terraform apply -auto-approve
```

## Destroy infrastructure
```bash
terraform destroy

# Check the Public IP in the output, will use in the next step
```

## Connect to EC2 Instance through SSH
```bash
ssh -i tf-key-pair ec2-user@EC2InstanceIP
```

## Resources
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl.html
- https://registry.terraform.io/providers/-/aws/latest/docs/data-sources/subnets
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet