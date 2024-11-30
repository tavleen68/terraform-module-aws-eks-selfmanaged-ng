# locals {
#   NIR = aws_iam_role.this.arn
# }

# data "aws_caller_identity" "current" {}
# locals {
#   aws_account_id = data.aws_caller_identity.current.account_id
# }
# ## ansible-playbook -i ${path.module}/bootstrap/inventory.ini ${path.module}/bootstrap/bootstrap-playbook.yml --extra-vars "aws_eks_cluster_name=${var.aws_eks_cluster_name}" --extra-vars "NIR=${local.NIR}" --extra-vars "calico_ippool_cidr_range=${var.calico_ippool_cidr_range}"

# resource "null_resource" "deploy_calico_custom_ippool" {
#   provisioner "local-exec" {
#     command = <<-EOT
#       ansible-playbook -i ${path.module}/bootstrap/inventory.ini ${path.module}/bootstrap/bootstrap-playbook.yml --extra-vars "aws_eks_cluster_name=${var.aws_eks_cluster_name}" --extra-vars "NIR=${local.NIR}" --extra-vars "calico_ippool_cidr_range=${var.calico_ippool_cidr_range}" --extra-vars "aws_account_id=${local.aws_account_id}"
#     EOT
#   }
#   triggers = {
#     key = uuid()
#   }
#   depends_on = [
#     aws_launch_template.this,
#     # aws_autoscaling_group.this
#   ]
# }
