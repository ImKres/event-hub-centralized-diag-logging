output "event_hub_name" {
  value = local.event_hub_name
}

output "event_hub_namespace_name" {
  value = local.event_hub_namespace_name
}

output "primary_connection_string" {
  value     = azurerm_eventhub_namespace.example.default_primary_connection_string
  sensitive = true
}

output "secondary_connection_string" {
  value     = azurerm_eventhub_namespace.example.default_secondary_connection_string
  sensitive = true
}

output "primary_key" {
  value     = azurerm_eventhub_namespace.example.default_primary_key
  sensitive = true
}

output "secondary_key" {
  value     = azurerm_eventhub_namespace.example.default_secondary_key
  sensitive = true
}

output "event_hub_rule_id" {
  value = azurerm_eventhub_authorization_rule.example.id
}

output "policy_id" {
  value = azurerm_policy_definition.custom_policy.id
}
