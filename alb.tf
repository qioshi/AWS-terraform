module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"
  
  name = "dev-alb"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = ["${element(module.vpc.public_subnets, 0)}", "${element(module.vpc.public_subnets, 1)}"]
  security_groups    = [module.web_sg.this_security_group_id]
  enable_http2       = false
  target_groups = [
    {
      name_prefix      = "dev-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "dev"
  }
}