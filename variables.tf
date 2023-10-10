variable "region_code" {
  description = "Provide AWS Region name to manage resources"
  type        = string
  default     = "us-east-1"
}

variable "task_role_name" {
  description = "Provide Task role for K8SEngineers PSQL service"
  type        = string
  default     = "k8spsql"
}

variable "cw_policy_name" {
  description = "Provide CloudWatch log group name for K8SEngineers PSQL"
  type        = string
  default     = "k8spsql_cw"
}

variable "ssm_policy_name" {
  description = "Provide System Manager name for PSQL K8SEngineers"
  type        = string
  default     = "k8spsql_ssm"
}

variable "task_name" {
  description = "Provide task definition name"
  type        = string
  default     = "k8spsql"
}

variable "nlb_sg_name" {
  description = "Provide PostgreSQL NLB SG name"
  type        = string
  default     = "k8spsql-nlb"
}

variable "service_sg_name" {
  description = "Provide PostgreSQL Service SG name"
  type        = string
  default     = "k8spsql-service"
}

variable "nlb_name" {
  description = "Provide NLB name for PostgreSQL"
  type        = string
  default     = "k8snlb-ecs"
}

variable "nlb_targetgroup_name" {
  description = "Provide TG name for NLB"
  type        = string
  default     = "k8snlb-tg-ecs"
}

variable "service_name" {
  description = "Provide ECS service name for PostgreSQL"
  type = string
  default = "k8spsql"
}

variable "container_name" {
  description = "Provide container name as per task definition section"
  type = string
  default = "k8spsql"
}

locals {
  common_tags = {
    "Environment" = "Production"
    "Type"        = "Fullstack"
  }
}