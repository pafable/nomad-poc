variable "key_name" {}

variable "sg" {}

variable "environment" {
  type    = string
  default = "Dev"
}

variable "tags" {
  type = map(string)
  default = {
    "Owner" : "phil",
    "Name" : "Nomad",
    "Email" : "my-email@test.com"
  }
}

variable "num" {
  type = map(string)
  default = {
    "Dev"  = 1
    "Prod" = 3
  }
}
