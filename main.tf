provider "aws" {
  region = "ap-south-1" # Replace with your AWS region
}

module "vpc" {
  source      = "./modules/vpc" # Relative path from main.tf
  cidr_block  = "10.0.0.0/16"
  name        = "my-vpc"
}

module "subnet" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  name              = "my-subnet"
}

module "autoscaling" {
  source        = "./modules/autoscaling"
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"
  subnets       = [module.subnet.subnet_id]
  name          = "my-autoscaling-group"
  min_size      = 1
  max_size      = 3
}
