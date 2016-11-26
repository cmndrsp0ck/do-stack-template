# Variable declaration for storage module
variable "project" {}

variable "region" {}

variable "image_slug" {
  type    = "string"
  default = "ubuntu-16-04-x64"
}

variable "keys" {}

variable "private_key_path" {}

variable "ssh_fingerprint" {}

variable "public_key" {}

variable "volume_size" {}

variable "storage_gateway_size" {
  default = "2gb"
}
