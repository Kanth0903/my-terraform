variable "vpc_cidr_block" {
    type = string
    default = ""
}
variable "subnet_cidr_block1" {
    type = string
    default = ""
}
variable "subnet_cidr_block2" {
    type = string
    default = ""
}
variable "route_cidr_block" {
    type = string
    default = ""
}
variable "inbound_port1" {
    type = number
    default = 22
}
variable "inbound_protocol1" {
    type = string
    default = ""
}
variable "cidr_block_sg1" {
    type = string
    default = ""
}
variable "inbound_port2" {
    type = number
    default = 443
}
variable "inbound_protocol2" {
    type = string
    default = ""
}
variable "cidr_block_sg2" {
    type = string
    default = ""
}
variable "inbound_port3" {
    type = number
    default = 80
}
variable "inbound_protocol3" {
    type = string
    default = ""
}
variable "cidr_block_sg3" {
    type = string
    default = ""
}
variable "ami_id" {
    type = string
    default = ""  
}
variable "instance_type" {
    type = string
    default = ""
}
variable "key_name" {
    type = string
    default = ""
}