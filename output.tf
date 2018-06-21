output "vnet" {
  value = "${
    map(
      "name", "${azurerm_virtual_network.vnet.name}",
      "address_space", "${join(",", azurerm_virtual_network.vnet.address_space)}",
    )
  }"
}

output "subnets" {
  value = "${
    map(
      "name", "${azurerm_subnet.subnets.*.name}",
    )
  }"
}
