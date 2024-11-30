variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = null
}

variable "eks_control_plane_sg_ssm_id" {
  description = "Security group ssm parameter store path of the cluster control plane sg"
  type        = string
  default     = null
}

variable "aws_eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = null
}

variable "disable_imdsv1" {
  description = "Disable Instance Metadata Service version 1"
  type        = bool
  default     = null
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = null
}

variable "node_auto_scaling_group_desired_capacity" {
  description = "The desired capacity of the node group"
  type        = number
  default     = null
}

variable "node_auto_scaling_group_max_size" {
  description = "The maximum size of the node group"
  type        = number
  default     = null
}

variable "node_auto_scaling_group_min_size" {
  description = "The minimum size of the node group"
  type        = number
  default     = null
}

variable "node_group_name_suffix" {
  description = "The suffix of the node group"
  type        = string
  default     = null
}

variable "node_image_id" {
  description = "The AMI ID for the nodes"
  type        = string
  default     = null
}

variable "node_image_id_ssm_param" {
  description = "The SSM parameter for the AMI ID"
  type        = string
  default     = null
}

variable "node_instance_type" {
  description = "The instance type for the nodes"
  type        = string
  default     = null
}

variable "node_volume_size" {
  description = "The size of the root volume for the nodes"
  type        = number
  default     = null
}

variable "node_volume_type" {
  description = "The type of the root volume for the nodes"
  type        = string
  default     = null
}

variable "subnet_ssm_id" {
  description = "The parameter store path for subnets id"
  type        = string
  default     = null
}

variable "vpc_ssm_id" {
  description = "The parameter store path for vpc id"
  type        = string
  default     = null
}

variable "bootstrap_arguments" {
  description = "Additional arguments to pass to the EKS bootstrap script"
  type        = string
  default     = ""
}

variable "default_tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}

variable "worker_node_additional_policy_arns" {
  description = "List of policy ARNs to attach to the IAM role"
  type        = list(string)
  default     = [] # Default empty list
}

variable "calico_ippool_cidr_range" {
  description = "ippool cidr range to be used for pod networking"
  type        = string
  default     = null
}

variable "enable_ebs_encryption" {
  description = "to enable encryption on ebs volume"
  type        = bool
  default     = null
}
variable "ebs_kms_key_arn_ssm_param" {
  description = "arn of the kms key to be used for ebs volume encryption"
  default     = null
  type        = string
}