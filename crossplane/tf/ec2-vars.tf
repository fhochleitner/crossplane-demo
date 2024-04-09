variable "ami_id" {
  description = "The AMI ID"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use"
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key pair name to use"
  type        = string
}

variable "instance_name" {
  description = "The instance name"
  default     = "MyEC2Instance"
}

variable "subnet_id" {
  description = "The ID of the subnet where the instance should be launched"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}