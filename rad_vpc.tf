//Providers
provider "aws" {
  access_key  = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
  region      = "${var.region}"
  version     = "~> 1.6"
}

provider "null" {
  version = "~> 2.1"
}

//VPC
resource "aws_vpc" "vpc_rad" {
    assign_generated_ipv6_cidr_block  = "false"
    enable_dns_hostnames              = "true"
    enable_dns_support                = "true"
    cidr_block                        = "${var.cidr_ipv4}"
    tags                              = {Name = "vpc_rad"}
}

//Public Subnet
resource "aws_subnet" "sn_public" {
  vpc_id                  = "${aws_vpc.vpc_rad.id}"
  cidr_block              = "${var.public_subnet}"
  #Hardcode Availability Zone to avoid t2.micro from getting created in 2d
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = "true"
  tags                    = {    Name = "sn_rad_public"  }
}
resource "aws_route_table" "rt_rad_public" {
  vpc_id  = "${aws_vpc.vpc_rad.id}"
  tags    = {Name = "rt_rad_public"}
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig_rad.id}"
  }
}
resource "aws_route_table_association" "rta_rad_public" {
  subnet_id      = "${aws_subnet.sn_public.id}"
  route_table_id = "${aws_route_table.rt_rad_public.id}"
}
resource "aws_internet_gateway" "ig_rad" {
  vpc_id  = "${aws_vpc.vpc_rad.id}"
  tags    = {Name="ig_rad"}
}