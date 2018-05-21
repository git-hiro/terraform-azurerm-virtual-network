variable "resource_group" {
  type = "map"

  default = {
    name = ""
  }
}


variable "vnet" {
  type = "map"

  default = {
    name = ""
  }
}

variable "vnet_address_spaces" {
  type = "list"

  default = []
}

variable "vnet_subnets" {
  type = "list"

  default = []
}

variable "nsg" {
  type = "map"

  default = {
    name        = ""
    subnet_name = ""
  }
}

variable "nsg_rules" {
  type = "list"

  default = []
}
