# EKS Terraform Module

Doc to be completed.
This Module comes with IAM role for the EKS Cluster
example usage
```
module "eks_cluster" {
  source       = "./path/to/eks-cluster-module"
  cluster_name = "my-eks-cluster"
  region       = "us-west-2"
  subnet_ids   = ["subnet-abc123", "subnet-def456"]
}


```