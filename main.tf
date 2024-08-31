data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg_example" {
  name     = var.resource_group_name
  location = var.location
}

resource "time_sleep" "wait_for_rg" {
  depends_on = [azurerm_resource_group.rg_example]
  create_duration = "120s"
}

resource "azurerm_eventhub_namespace" "example" {
  name                         = local.event_hub_namespace_name
  location                     = var.location
  resource_group_name          = azurerm_resource_group.rg_example.name
  sku                          = var.event_hub_sku
  capacity                     = var.event_hub_capacity
  minimum_tls_version          = "1.2"
  local_authentication_enabled = false

  depends_on = [time_sleep.wait_for_rg]
}

resource "azurerm_eventhub" "example" {
  name                = local.event_hub_name
  namespace_name      = azurerm_eventhub_namespace.example.name
  resource_group_name = azurerm_resource_group.rg_example.name
  partition_count     = var.event_hub_partition_count
  message_retention   = var.event_hub_message_retention

  depends_on = [azurerm_eventhub_namespace.example]
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-log-analytics"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [time_sleep.wait_for_rg]
}

resource "azurerm_monitor_action_group" "example" {
  name                = "example-action-group"
  resource_group_name = azurerm_resource_group.rg_example.name
  short_name          = "example"

  email_receiver {
    name          = "example-email-receiver"
    email_address = var.action_group_email
  }

  depends_on = [time_sleep.wait_for_rg]
}

resource "azurerm_eventhub_authorization_rule" "example" {
  name                = "example-rule"
  namespace_name      = azurerm_eventhub_namespace.example.name
  eventhub_name       = azurerm_eventhub.example.name
  resource_group_name = azurerm_resource_group.rg_example.name
  listen              = true 
  send                = true 
}

resource "azurerm_user_assigned_identity" "example" {
  name                = "example-identity"
  resource_group_name = var.resource_group_name
  location            = var.location

  depends_on = [time_sleep.wait_for_rg]
}