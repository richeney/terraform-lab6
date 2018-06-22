resource "azurerm_resource_group" "keyvaults" {
    name        = "keyVaults"
    location    = "${var.loc}"
    tags        = "${var.tags}"
}


resource "azurerm_role_assignment" "keyVaultReader" {
  role_definition_name = "Reader"
  scope                = "${azurerm_resource_group.keyvaults.id}"
  principal_id         = "${var.object_id}"
}


resource "random_string" "rndstr" {
  length  = 12
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_key_vault" "default" {
    name                = "keyVault${random_string.rndstr.result}"
    resource_group_name = "${azurerm_resource_group.keyvaults.name}"
    location            = "${azurerm_resource_group.keyvaults.location}"
    tags                = "${azurerm_resource_group.keyvaults.tags}"

    depends_on          = [ "azurerm_role_assignment.keyVaultReader" ]

    sku {
        name = "standard"
    }

    tenant_id = "${var.tenant_id}"

    access_policy {
      tenant_id             = "${var.tenant_id}"
      object_id             = "${var.object_id}"
      key_permissions       = [ "get" ]
      secret_permissions    = [ "get" ]
    }
    enabled_for_deployment          = false # Azure Virtual Machines permitted to retrieve certs?
    enabled_for_template_deployment = false # ARM deployments allowed to pull secrets?
    enabled_for_disk_encryption     = true  # Azure Disk Encryptions permitted to grab secrets and unwrap keys ?
}