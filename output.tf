output "nsg" {
  value = "${
    map(
      "id", "${azurerm_network_security_group.nsg.id}",
      "name", "${azurerm_network_security_group.nsg.name}",
    )
  }"
}

output "nsg_rules" {
  value = "${
    map(
      "id", "${azurerm_network_security_rule.nsg_rules.*.id}",
      "name", "${azurerm_network_security_rule.nsg_rules.*.name}",
    )
  }"
}

output "vnet" {
  value = "${
    map(
      "id", "${azurerm_virtual_network.vnet.id}",
      "name", "${azurerm_virtual_network.vnet.name}",
    )
  }"
}

output "vnet_subnets" {
  value = "${
    map(
      "id", "${azurerm_subnet.vnet_subnets.*.id}",
      "name", "${azurerm_subnet.vnet_subnets.*.name}",
    )
  }"
}
