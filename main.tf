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