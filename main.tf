resource "azurerm_network_security_group" "nsg" {
  resource_group_name = "${var.resource_group["name"]}"

  name     = "${var.nsg["name"]}"
  location = "${var.nsg["location"]}"
}

resource "azurerm_network_security_rule" "nsg_rules" {
  count = "${length(var.nsg_rules)}"

  resource_group_name         = "${var.resource_group["name"]}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"

  name     = "${lookup(var.nsg_rules[count.index], "name")}"
  priority = "${lookup(var.nsg_rules[count.index], "priority")}"

  access    = "${lookup(var.nsg_rules[count.index], "access")}"
  direction = "${lookup(var.nsg_rules[count.index], "direction")}"
  protocol  = "${lookup(var.nsg_rules[count.index], "protocol")}"

  source_address_prefix      = "${lookup(var.nsg_rules[count.index], "source_address_prefix")}"
  source_port_range          = "${lookup(var.nsg_rules[count.index], "source_port_range")}"
  destination_address_prefix = "${lookup(var.nsg_rules[count.index], "destination_address_prefix")}"
  destination_port_range     = "${lookup(var.nsg_rules[count.index], "destination_port_range")}"

  depends_on = ["azurerm_network_security_group.nsg"]
}

resource "azurerm_virtual_network" "vnet" {
  resource_group_name = "${var.resource_group["name"]}"

  name     = "${var.vnet["name"]}"
  location = "${var.vnet["location"]}"

  address_space = "${var.vnet_address_spaces}"
}

resource "azurerm_subnet" "vnet_subnets" {
  count = "${length(var.vnet_subnets)}"

  resource_group_name  = "${var.resource_group["name"]}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"

  name = "${lookup(var.vnet_subnets[count.index], "name")}"

  address_prefix            = "${lookup(var.vnet_subnets[count.index], "address_prefix")}"
  network_security_group_id = "${azurerm_network_security_group.nsg.id}"

  depends_on = ["azurerm_network_security_group.nsg"]
}
