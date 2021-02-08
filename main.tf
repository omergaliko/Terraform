terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }     
    }   
}
provider "aws" { 
    region = var.region 
    access_key = "access_key" 
    secret_key = "secret_key"

} 
module "network" {
    source = "./module_vpc_subnet"
    vpc_cidr_block = "10.0.0.0/16"
    public_subnet  = "10.0.0.0/24"
    private_subnet = "10.0.10.0/24"
}

module "security_group" {
    source = "./module_security_group"
    vpc_id = module.network.aws_vpc 
}

module "instance_public" {
    source = "./module_instance"
    availability_zone = "us-east-2a"
    ami = "ami-0a91cd140a1fc148a"
    key_name = "key_pem"
    instance_type = "t2.micro"
    subnet_id = module.network.aws_subnet_public
    security_group = module.security_group.public_security_group
    Tag_name = "Nginx"
}

module "instance_private" {
    source = "./module_instance"
    availability_zone = "us-east-2a"
    ami = "ami-0a91cd140a1fc148a"
    key_name = "key_pem"
    instance_type = "t2.micro"
    subnet_id = module.network.aws_subnet_private
    security_group = module.security_group.private_security_group
    Tag_name = "MySQL"
}
