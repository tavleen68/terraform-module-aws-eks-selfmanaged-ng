## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.registry_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker-node-additional-policy-attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [null_resource.deploy_calico_custom_ippool](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [aws_ssm_parameter.ebs_kms_key_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.eks_cluster_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.node_image_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.subnets_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.vpc_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_eks_cluster_name"></a> [aws\_eks\_cluster\_name](#input\_aws\_eks\_cluster\_name) | The name of the EKS cluster | `string` | `null` | no |
| <a name="input_bootstrap_arguments"></a> [bootstrap\_arguments](#input\_bootstrap\_arguments) | Additional arguments to pass to the EKS bootstrap script | `string` | `""` | no |
| <a name="input_calico_ippool_cidr_range"></a> [calico\_ippool\_cidr\_range](#input\_calico\_ippool\_cidr\_range) | ippool cidr range to be used for pod networking | `string` | `null` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | tags to be added to the resources | `map(string)` | `{}` | no |
| <a name="input_disable_imdsv1"></a> [disable\_imdsv1](#input\_disable\_imdsv1) | Disable Instance Metadata Service version 1 | `bool` | `null` | no |
| <a name="input_ebs_kms_key_arn_ssm_param"></a> [ebs\_kms\_key\_arn\_ssm\_param](#input\_ebs\_kms\_key\_arn\_ssm\_param) | arn of the kms key to be used for ebs volume encryption | `string` | `null` | no |
| <a name="input_eks_control_plane_sg_ssm_id"></a> [eks\_control\_plane\_sg\_ssm\_id](#input\_eks\_control\_plane\_sg\_ssm\_id) | Security group ssm parameter store path of the cluster control plane sg | `string` | `null` | no |
| <a name="input_enable_ebs_encryption"></a> [enable\_ebs\_encryption](#input\_enable\_ebs\_encryption) | to enable encryption on ebs volume | `bool` | `null` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The name of the key pair to use for SSH access | `string` | `null` | no |
| <a name="input_node_auto_scaling_group_desired_capacity"></a> [node\_auto\_scaling\_group\_desired\_capacity](#input\_node\_auto\_scaling\_group\_desired\_capacity) | The desired capacity of the node group | `number` | `null` | no |
| <a name="input_node_auto_scaling_group_max_size"></a> [node\_auto\_scaling\_group\_max\_size](#input\_node\_auto\_scaling\_group\_max\_size) | The maximum size of the node group | `number` | `null` | no |
| <a name="input_node_auto_scaling_group_min_size"></a> [node\_auto\_scaling\_group\_min\_size](#input\_node\_auto\_scaling\_group\_min\_size) | The minimum size of the node group | `number` | `null` | no |
| <a name="input_node_group_name_suffix"></a> [node\_group\_name\_suffix](#input\_node\_group\_name\_suffix) | The suffix of the node group | `string` | `null` | no |
| <a name="input_node_image_id"></a> [node\_image\_id](#input\_node\_image\_id) | The AMI ID for the nodes | `string` | `null` | no |
| <a name="input_node_image_id_ssm_param"></a> [node\_image\_id\_ssm\_param](#input\_node\_image\_id\_ssm\_param) | The SSM parameter for the AMI ID | `string` | `null` | no |
| <a name="input_node_instance_type"></a> [node\_instance\_type](#input\_node\_instance\_type) | The instance type for the nodes | `string` | `null` | no |
| <a name="input_node_volume_size"></a> [node\_volume\_size](#input\_node\_volume\_size) | The size of the root volume for the nodes | `number` | `null` | no |
| <a name="input_node_volume_type"></a> [node\_volume\_type](#input\_node\_volume\_type) | The type of the root volume for the nodes | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy in | `string` | `null` | no |
| <a name="input_subnet_ssm_id"></a> [subnet\_ssm\_id](#input\_subnet\_ssm\_id) | The parameter store path for subnets id | `string` | `null` | no |
| <a name="input_vpc_ssm_id"></a> [vpc\_ssm\_id](#input\_vpc\_ssm\_id) | The parameter store path for vpc id | `string` | `null` | no |
| <a name="input_worker_node_additional_policy_arns"></a> [worker\_node\_additional\_policy\_arns](#input\_worker\_node\_additional\_policy\_arns) | List of policy ARNs to attach to the IAM role | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
