variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "sg_load_balancer_fastfood" {
  description = "SG Load Balancer FastFood"
  type        = string
  default     = "sg-0984492cc7da3f5da"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-02704242632eb2597"
}
