variable "region" {
   default = "ap-southeast-1"
}
variable "vpc_cidr" {
  default = "192.168.0.0/23"
}
variable "access_key" {
    default = "aws_access_key"
}
variable "secret_key" {
    default = "aws_secret_key"
}
variable "public_cidr" {
    default = "192.168.0.0/24"
}
variable "private_cidr" {
    default = "192.168.1.0/24"
}
variable "image_id" {
    default = "ami-03ca998611da0fe12"
}