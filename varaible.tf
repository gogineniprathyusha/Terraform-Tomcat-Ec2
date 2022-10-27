variable "ami" {
  type    = string
  description = "The id of the mcahine image (AMI) to use for the server"
  default = "ami-0085cb15f77b065b9"
}

variable "instance_type" {
  type    = string
  description = "The id of the mcahine image (AMI) to use for the server"
  default = "t2.micro"
}