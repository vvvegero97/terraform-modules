variable "domains" {
  description = "A list of objects containing domain names and their corresponding zone names."
  type = list(object({
    domain    = string
    zone_name = string
  }))
  default = [
    {
      zone_name = "example.com"
      domain    = "my.example.com"
    }
  ]
}
