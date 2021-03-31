module "web_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "web-sg"
  description = "Security group for webservers"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["10.0.0.0/16"]
  ingress_rules            = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http ports"
      cidr_blocks = "122.55.14.126/32"
    },
  ]
  egress_rules = ["all-all"]
}

module "bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "web-sg"
  description = "Security group for webservers"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["10.0.0.0/16"]
  ingress_rules            = ["http-80-tcp", "all-icmp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh ports"
      cidr_blocks = "122.55.14.126/32"
    }
  ]
  egress_rules = ["all-all"]
}
