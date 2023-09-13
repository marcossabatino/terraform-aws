provider "aws" {
  region = "us-east-2"
}

data "aws_availability_zones" "available" {}

resource "aws_rds_cluster" "aurora_cluster_mysql" {
  cluster_identifier      = "aurora-cluster-base"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.02.0"
  availability_zones      = ["us-east-2a", "us-east-2b", "us-east-2c"]
  database_name           = "mysqldb"
  master_username         = var.rds_master_username
  master_password         = var.rds_master_password
  backup_retention_period = 7
  preferred_backup_window = "02:00-05:00"
  final_snapshot_identifier = "base-final-snapshot"
}

resource "aws_rds_cluster_instance" "aurora_cluster_instances" {
  count                 = 3
  cluster_identifier    = aws_rds_cluster.aurora_cluster_mysql.id
  instance_class        = "db.t3.small"
  engine                = "aurora-mysql"
}



module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  
  name                 = "vpc_rds"
  cidr                 = "10.0.0.0/16"
  azs                  = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}
