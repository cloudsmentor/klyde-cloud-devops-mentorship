########################
#         EKS          #
########################
module "eks_cluster" {
  source = "./modules/eks"

  name = var.name

  subnet_ids                    = module.subnets.subnet_ids
  node_group_name               = var.name
  desired_size                  = 1
  max_size                      = 3
  min_size                      = 1
  ami_type                      = "AL2_x86_64"
  instance_types                = ["m5.large"]
  capacity_type                 = "ON_DEMAND"
  policy_arns                   = {
    "AmazonEKSWorkerNodePolicy" = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", 
    "AmazonEKS_CNI_Policy" = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    "AmazonEC2ContainerRegistryReadOnly" = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  }
  kubernetes_version            = "1.29"
  tags                          = module.tags.tags
}

# Output the EKS cluster name
output "eks_cluster_name" {
  value = module.eks_cluster.eks_cluster_name
}