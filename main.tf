provider "aws" {
  region = var.aws_region
}

#Configuração do Terraform State
terraform {
  backend "s3" {
    bucket = "terraform-state-soat"
    key    = "cluster-ecs/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-state-soat-locking"
    encrypt        = true
  }
}

### ECS CONFIG ###

resource "aws_ecs_cluster" "cluster_ecs_soat" {
  name = "cluster-ecs-soat"

  tags = {
    infra = "cluster-ecs-soat"
  }
}

resource "aws_security_group_rule" "security_group_cluster_ecs_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.security_group_cluster_ecs
  depends_on        = [aws_ecs_cluster.cluster_ecs_soat]
}
