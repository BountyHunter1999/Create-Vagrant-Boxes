variable "ami_prefix" {
  type        = string
  description = "The prefix for the AMI name"
  default     = "packer-ubuntu"
}

variable "ami_filter_name" {
  type        = string
  description = "The name of the AMI filter to use"
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server*"
}

variable "region" {
  type        = string
  description = "The region to build the AMI in"
  default     = "us-east-2"
}

variable "instance_type" {
  type        = string
  description = "The instance type to build the AMI on"
  default     = "t2.micro"
}

variable "ssh_username" {
  type        = string
  description = "The username for SSH authentication"
  default     = "ubuntu"
}

variable "ssh_timeout" {
  type        = string
  description = "The timeout for SSH authentication"
  default     = "15m"
}

variable "creator" {
  type        = string
  description = "The creator of the AMI"
  default     = "packer"
}

variable "use_docker" {
  type        = bool
  description = "Whether to install Docker"
  default     = false
}

variable "use_nerdctl" {
  type        = bool
  description = "Whether to install Nerdctl"
  default     = false
}