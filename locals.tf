locals {
  event_hub_namespace_name = "${var.event_hub_name}-${var.environment}-${var.location}-eventhub-namespace"
  event_hub_name           = "${var.event_hub_name}-${var.environment}-${var.location}-eventhub"
  event_hub_rule_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.EventHub/namespaces/${local.event_hub_namespace_name}/authorizationRules/RootManageSharedAccessKey"
}
