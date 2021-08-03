locals {
  tf_tags = jsonencode([for key, value in var.tags: {
    Key   = key,
    Value = value
  }])
}

resource "aws_cloudformation_stack" "emr_eks_test" {
  name = var.emr_virtual_cluster_name

  template_body = templatefile("${path.module}/emr_containers_template.json", {
    eks_cluster_name = var.eks_cluster_name
    eks_name_space   = var.eks_namespace
    emr_cluster_name = var.emr_virtual_cluster_name
    tags             = local.tf_tags
  })
}
