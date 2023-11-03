variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "security_group_cluster_ecs" {
  description = "Cluster ECS Security group"
  type    = string
  default = "value"
}
