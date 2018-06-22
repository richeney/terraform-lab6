resource "azurerm_resource_group" "deleteme" {
    name        = "deleteme"
    location    = "${var.loc}"
    tags        = "${var.tags}"
}