########################
#         EKS          #
########################

module "eks_cluster" {
  source = "./modules/eks-cluster"

  name                    = var.name
  subnet_ids              = concat(module.public_subnets.subnet_ids, module.private_subnets.subnet_ids)
  security_group_ids      = [module.cluster_sg.security_group_id]
  endpoint_public_access  = true
  endpoint_private_access = true
  public_access_cidrs     = ["0.0.0.0/0"]
  iam_role_policy_arns = {
    "AmazonEKSClusterPolicy" = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  }

  tags = module.tags.tags
}

module "eks_node_group" {
  source = "./modules/eks-node-group"

  name         = var.name
  cluster_name = module.eks_cluster.eks_cluster_name

  subnet_ids     = module.private_subnets.subnet_ids
  desired_size   = 2
  max_size       = 3
  min_size       = 1
  ami_type       = "AL2_x86_64"
  instance_types = [ "m5.large"]
  capacity_type  = "ON_DEMAND"
  iam_role_policy_arns = {
    "AmazonEKSWorkerNodePolicy"          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy"               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    "AmazonEC2ContainerRegistryReadOnly" = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  }
  kubernetes_version = "1.29"

  tags = module.tags.tags
}

