variable "ami_ec2" {
  default=       "ami-0385455dc2b1498ef"     
}
variable "ami_nat" {
  default=       "ami-0b840e8a1ce4cdf15"     
}
variable "ami_ubuntu1804" {
  default=       "ami-005bdb005fb00e791"     
}
variable "aws_access_key" {
  default     = ""
  description = "Amazon AWS Access Key"
}
variable "aws_secret_key" {
  default     = ""
  description = "Amazon AWS Secret Key"
}
variable "region" {
  default     = "us-west-2"
  description = "Amazon AWS Region for deployment"
}

variable "type" {
  default     = "t2.micro"
  description = "Amazon AWS Instance Type"
}
variable "ssh_key_name" {
  default     = ""
  description = "Amazon AWS Key Pair Name"
}
variable "ssh_key_file_name" {
  default     = ".pem"
  description = "Amazon AWS Key Pair Name with the extension of the actual file name"
}
variable "ssh_key_path" {
  description = "Path to the keyfile relative to the terraform repo"
  default = ""
}

variable "cidr_ipv4" {
  description = "CIDR for IPV4"
  default = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "Public Subnet CIDR"
  default = "10.0.0.0/24"
}
variable "private_subnet" {
  description = "Private Subnet CIDR"
  default = "10.0.1.0/24"
}