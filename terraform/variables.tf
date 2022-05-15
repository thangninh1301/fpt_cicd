variable "vpc_cidr_block" {
  type    = string
  default = "10.1.0.0/16"
}

variable "private_subnet" {
  type    = list(string)
  default = ["10.1.1.0/24","10.1.6.0/24"]
}

variable "public_subnet" {
  type    = list(string)
  default = ["10.1.2.0/24"]
}

variable "availability_zone" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^ami-", var.image_id))
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }

  default = "ami-0f2ea204cd818ce8e"
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "key pem"
  type        = string
  default     = "thangnd45"
}

variable "instance_name" {
  type    = list(string)
  default = ["jenkins", "production", "staging"]
}