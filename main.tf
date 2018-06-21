data "azurerm_network_security_group" "nsg" {
  count = "${length(var.subnets)}"

  resource_group_name = "${lookup(var.subnets[count.index], "nsg_resource_group_name")}"
  name                = "${lookup(var.subnets[count.index], "nsg_name")}"
}

resource "azurerm_virtual_network" "vnet" {
  resource_group_name = "${var.vnet["resource_group_name"]}"

  name     = "${var.vnet["name"]}"
  location = "${var.vnet["location"]}"

  address_space = ["${compact(split(",", var.vnet["address_spaces"]))}"]
}

resource "azurerm_subnet" "subnets" {
  count = "${length(var.subnets)}"

  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"

  name = "${lookup(var.subnets[count.index], "name")}"

  address_prefix    = "${lookup(var.subnets[count.index], "address_prefix")}"
  service_endpoints = ["${compact(split(",", lookup(var.subnets[count.index], "service_endpoints")))}"]

  network_security_group_id = "${element(data.azurerm_network_security_group.nsg.*.id, count.index)}"
}
