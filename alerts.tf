# Metric Alerts
resource "azurerm_monitor_metric_alert" "incoming_messages_alert" {
  name                = "eventhub-incoming-messages-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_eventhub_namespace.example.id]
  description         = "Alert for Event Hub incoming messages"
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.EventHub/Namespaces"
    metric_name      = "IncomingMessages"
    aggregation      = "Total"
    operator         = "LessThan"
    threshold        = var.incoming_messages_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.example.id
  }
}

resource "azurerm_monitor_metric_alert" "outgoing_messages_alert" {
  name                = "eventhub-outgoing-messages-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_eventhub_namespace.example.id]
  description         = "Alert for Event Hub outgoing messages"
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.EventHub/Namespaces"
    metric_name      = "OutgoingMessages"
    aggregation      = "Total"
    operator         = "LessThan"
    threshold        = var.outgoing_messages_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.example.id
  }
}

resource "azurerm_monitor_metric_alert" "throughput_units_alert" {
  name                = "eventhub-throughput-units-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_eventhub_namespace.example.id]
  description         = "Alert for Event Hub throughput units"
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.EventHub/Namespaces"
    metric_name      = "ThrottledRequests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.throttled_requests_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.example.id
  }
}

resource "azurerm_monitor_metric_alert" "active_connections_alert" {
  name                = "eventhub-active-connections-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_eventhub_namespace.example.id]
  description         = "Alert for Event Hub active connections"
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.EventHub/Namespaces"
    metric_name      = "ActiveConnections"
    aggregation      = "Minimum"
    operator         = "LessThan"
    threshold        = var.active_connections_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.example.id
  }
}

resource "azurerm_monitor_metric_alert" "captured_messages_alert" {
  name                = "eventhub-captured-messages-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_eventhub_namespace.example.id]
  description         = "Alert for Event Hub captured messages"
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.EventHub/Namespaces"
    metric_name      = "CapturedMessages"
    aggregation      = "Total"
    operator         = "LessThan"
    threshold        = var.throttled_requests_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.example.id
  }
}
