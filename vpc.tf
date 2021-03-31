module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "dev-vpc"

  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  manage_default_route_table = true
  enable_nat_gateway = true
  single_nat_gateway = false

  public_subnet_tags = {
    Name = "dev-public"
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "dev-vpc"
  }
}



output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}