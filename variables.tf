# General
variable "common_tags" {
  type        = map(string)
  description = "The list of common tags"
}


# EC2 Instance
variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}

variable "instance_name_prefix" {
  type        = string
  description = "EC2 Instance Prefix Name"
}

variable "instance_numbers" {
  type        = number
  description = "number of instances to be created"
}

# Security Group
variable "sg_name" {
  type        = string
  description = "The name of the Security Group"
}

variable "sg_description" {
  type        = string
  description = "The description of the Security Group"
}

variable "sg_inbound_rules" {
  type = list(object({
    description = string,
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_blocks = list(string)
  }))
  description = "The ingres values of the Security Group"
}

# Load Balancer

variable "lb_name" {
  type        = string
  description = "The name of the Load Balancer"
}

variable "tg_prefix_name" {
  type        = string
  description = "The Target Group prefix name"
}

# ACL

variable "web_acl_name" {
  type        = string
  description = "The Name of the Web ACL"
}
