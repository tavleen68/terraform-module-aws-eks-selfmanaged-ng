locals {
  nodegroup_id = "${var.aws_eks_cluster_name}-${var.node_group_name_suffix}"
  kms_key_arn  = data.aws_ssm_parameter.ebs_kms_key_arn.value
}

data "aws_ssm_parameter" "ebs_kms_key_arn" {
  name = var.ebs_kms_key_arn_ssm_param
}

data "aws_ssm_parameter" "node_image_id" {
  name = var.node_image_id_ssm_param
}

data "aws_ssm_parameter" "eks_cluster_sg" {
  name = var.eks_control_plane_sg_ssm_id
}

data "aws_ssm_parameter" "vpc_id" {
  name = var.vpc_ssm_id
}
data "aws_ssm_parameter" "subnets_id" {
  name = var.subnet_ssm_id
}

resource "aws_iam_instance_profile" "this" {
  name = "${local.nodegroup_id}-instance-profile"
  role = aws_iam_role.this.name
}

resource "aws_launch_template" "this" {
  name_prefix = "${local.nodegroup_id}-launch-template"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = true
      volume_size           = var.node_volume_size
      volume_type           = var.node_volume_type
      encrypted             = var.enable_ebs_encryption
      kms_key_id            = local.kms_key_arn
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  image_id      = var.node_image_id != "" ? var.node_image_id : data.aws_ssm_parameter.node_image_id.value
  instance_type = var.node_instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [data.aws_ssm_parameter.eks_cluster_sg.value]
  }

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    cluster_name        = var.aws_eks_cluster_name
    stack_name          = var.aws_eks_cluster_name
    region              = var.region
    bootstrap_arguments = var.bootstrap_arguments
  }))

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = var.disable_imdsv1 ? "required" : "optional"
    http_put_response_hop_limit = 2
  }
  tag_specifications {
    resource_type = "instance"
    tags = merge(var.default_tags, {
      Name = "${local.nodegroup_id}-instance"
      ClusterName : var.aws_eks_cluster_name
    })
  }
}

# resource "aws_autoscaling_group" "this" {
#   desired_capacity    = var.node_auto_scaling_group_desired_capacity
#   max_size            = var.node_auto_scaling_group_max_size
#   min_size            = var.node_auto_scaling_group_min_size
#   vpc_zone_identifier = [data.aws_ssm_parameter.subnets_id.value]  ##var.subnets ##(",", var.subnets)
#   launch_template {
#     id      = aws_launch_template.this.id
#     version = "$Latest"
#   # }

#   tag {
#     key                 = "Name"
#     value               = "${local.nodegroup_id}-node"
#     propagate_at_launch = true
#   }

#   tag {
#     key                 = "kubernetes.io/cluster/${var.aws_eks_cluster_name}"
#     value               = "owned"
#     propagate_at_launch = true
#   }

# }

resource "aws_iam_role" "this" {
  name = "${local.nodegroup_id}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = var.default_tags
}

resource "aws_iam_role_policy_attachment" "node_group" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "registry_policy" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "worker-node-additional-policy-attachments" {
  count      = length(var.worker_node_additional_policy_arns) > 0 ? length(var.worker_node_additional_policy_arns) : 0 # Set count based on policy_arns length
  role       = aws_iam_role.this.name
  policy_arn = var.worker_node_additional_policy_arns[count.index]
}
