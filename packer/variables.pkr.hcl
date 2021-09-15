variable "tags" {
  type = map(string)
  default = {
    "Owner" : "phil",
    "Name" : "nomad",
    "Email": "my-email-test@123test.com"
  }
}
