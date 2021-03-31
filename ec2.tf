module "ec2_web1" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "web1"
  instance_count         = 1

  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  key_name               = "1"
  monitoring             = true
  vpc_security_group_ids = [module.web_sg.this_security_group_id]
  subnet_id              = "${element(module.vpc.private_subnets, 0)}"

  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
sudo yum install httpd -y
sudo service httpd start
EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2_web2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "web2"
  instance_count         = 1

  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  key_name               = "1"
  monitoring             = true
  vpc_security_group_ids = [module.web_sg.this_security_group_id]
  subnet_id              = "${element(module.vpc.private_subnets, 1)}"

  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
sudo yum install httpd -y
sudo service httpd start
EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2_bastion" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "bastion"
  instance_count         = 1

  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  key_name               = "1"
  monitoring             = true
  vpc_security_group_ids = [module.bastion_sg.this_security_group_id]
  subnet_id              = "${element(module.vpc.public_subnets, 1)}"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}