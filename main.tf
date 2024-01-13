provider "aws" {
  region = var.aws_region
}

#Configuração do Terraform State
terraform {
  backend "s3" {
    bucket = "terraform-state-soat"
    key    = "fastfood-cluster-ecs/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-state-soat-locking"
    encrypt        = true
  }
}

### ECS CONFIG ###
resource "aws_ecs_cluster" "cluster_ecs_soat" {
  name = "fastfood-cluster-ecs"

  tags = {
    infra   = "ecs-fastfood"
    service = "fastfood"
  }
}

#Security Group ECS
resource "aws_security_group" "security_group_fastfood_ecs" {
  name_prefix = "security-group-fastfood-ecs"
  description = "SG for FastFood ECS Cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [var.sg_load_balancer_fastfood]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    infra   = "ecs-fastfood"
    service = "fastfood"
    Name    = "security-group-fastfood-ecs"
  }
}

output "security_group_ecs_id" {
  value = aws_security_group.security_group_fastfood_ecs.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.security_group_fastfood_ecs.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}