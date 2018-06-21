variable "vnet" {
  default = {
    resource_group_name = ""

    name     = ""
    location = "japaneast"

    address_spaces = ""
  }
}

variable "subnets" {
  default = []
}
