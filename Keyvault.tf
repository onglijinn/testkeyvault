resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
}

resource "azurerm_key_vault" "trial202keyvault" {
  name                        = "trial202keyvault" // resource groupnmae has to be a global unique name as well
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = false
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
      "list",
      "create",
      "delete",
      "update",
      "wrapKey",
      "unwrapKey"
    ]

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
    ]

    certificate_permissions = [
      "get",
      "list",
      "create",
      "delete",
      "update",
    ]

  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = {
    environment = "Testing"
  }
}