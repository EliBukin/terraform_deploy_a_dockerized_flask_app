# AWS Config
variable "aws_access_key" {
  default = "accesskey"
}

variable "aws_secret_key" {
  default = "secretkey"
}

variable "aws_key_name" {
	description = "The name of the key that will be used"
	default     = "sshkey"
}

variable "aws_private_key_location" {
	description = "location of the .pem file"
	default     = "/path/to/key.pem"
}

variable "aws_region" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "eu-west-1"
}

# VM Config
variable "ami_id" {
	description = "The AMI that will be used"
	default     = "ami-0c379e7083fbe41ab"
}

variable "vm_size" {
	description = "Size of the VM that is created"
	default     = "t2.micro"
}

# Security group
variable "web_server_port" {
  description = "web_server_port_8080"
  default     = "8080"
}

variable "ssh_port" {
  description = "ssh_port_22"
  default     = "22"
}

variable "flask_port" {
  description = "flask_port_8888"
  default     = "8888"
}
