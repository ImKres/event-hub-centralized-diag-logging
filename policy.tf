resource "azurerm_policy_definition" "custom_policy" {
  name         = "custom-policy-definition"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Custom Policy to Send Logs to Event Hub"
  description  = "Custom policy to send logs to Event Hub."
  management_group_id = "/providers/Microsoft.Management/managementGroups/mg-001"
 
  parameters = jsonencode({
    effect = {
      type          = "String"
      metadata      = { displayName = "Effect", description = "Enable or disable the execution of the policy" }
      allowedValues = ["DeployIfNotExists", "AuditIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
    }
    profileName = {
      type        = "String"
      metadata    = { displayName = "Profile name", description = "The diagnostic settings profile name" }
      defaultValue = "setbypolicy_blobDiagSettingsToEventHub"
    }
    metricsEnabled = {
      type          = "Boolean"
      metadata      = { displayName = "Enable metrics", description = "Whether to enable metrics stream to the Event Hub - True or False" }
      allowedValues = [true, false]
      defaultValue  = true
    }
    logsEnabled = {
      type          = "Boolean"
      metadata      = { displayName = "Enable logs", description = "Whether to enable logs stream to the Event Hub - True or False" }
      allowedValues = [true, false]
      defaultValue  = true
    }
    eventHubRuleId = {
      type           = "String"
      metadata       = { displayName = "Event Hub Authorization Rule Id", description = "The Event Hub authorization rule Id for Azure Diagnostics.", strongType = "Microsoft.EventHub/Namespaces/AuthorizationRules", assignPermissions = true }
    }
    eventHubName = {
      type        = "String"
      metadata    = { displayName = "Event Hub Name", description = "Specify the name of the Event Hub" }
    }
    eventHubLocation = {
      type        = "String"
      metadata    = { displayName = "Event Hub Location", description = "Resource Location must be in the same location as the Event Hub Namespace.", strongType = "location" }
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        { field = "type", equals = "Microsoft.Storage/storageAccounts/blobServices" },
        {
          anyOf = [
            { value = "[parameters('eventHubLocation')]", equals = "" },
            { field = "location", equals = "[parameters('eventHubLocation')]" }
          ]
        }
      ]
    }
    then = {
      effect = "[parameters('effect')]"
      details = {
        type                 = "Microsoft.Insights/diagnosticSettings"
        name                 = "[parameters('profileName')]"
        existenceCondition   = {
          allOf = [
            {
              count = {
                field = "Microsoft.Insights/diagnosticSettings/metrics[*]",
                where = {
                  allOf = [
                    { field = "Microsoft.Insights/diagnosticSettings/metrics[*].category", equals = "Transaction" },
                    { field = "Microsoft.Insights/diagnosticSettings/metrics[*].enabled", equals = "[parameters('metricsEnabled')]" }
                  ]
                }
              }
              equals = 1
            },
            { field = "Microsoft.Insights/diagnosticSettings/logs.enabled", equals = "[parameters('logsEnabled')]" },
            { field = "Microsoft.Insights/diagnosticSettings/eventHubAuthorizationRuleId", matchInsensitively = "[parameters('eventHubRuleId')]" },
            { field = "Microsoft.Insights/diagnosticSettings/eventHubName", matchInsensitively = "[parameters('eventHubName')]" }
          ]
        }
        roleDefinitionIds = [
          "/providers/microsoft.authorization/roleDefinitions/<RoleDefinitionIds>", #Change to specific Role DefinitionIds
          "/providers/microsoft.authorization/roleDefinitions/<RoleDefinitionIds>"
        ]
        deployment = {
          properties = {
            mode    = "incremental"
            template = {
              "$schema"         = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
              contentVersion    = "1.0.0.0"
              parameters        = {
                resourceName  = { type = "string" }
                location      = { type = "string" }
                eventHubRuleId = { type = "string" }
                eventHubName  = { type = "string" }
                metricsEnabled = { type = "bool" }
                logsEnabled   = { type = "bool" }
                profileName   = { type = "string" }
              }
              resources = [
                {
                  type       = "Microsoft.Storage/storageAccounts/blobServices/providers/diagnosticSettings"
                  apiVersion = "2021-05-01-preview"
                  name       = "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
                  location   = "[parameters('location')]"
                  properties = {
                    eventHubAuthorizationRuleId = "[parameters('eventHubRuleId')]"
                    eventHubName               = "[parameters('eventHubName')]"
                    metrics = [
                      {
                        timeGrain       = null
                        enabled         = false
                        retentionPolicy = {
                          days   = 0
                          enabled = false
                        }
                        category = "Capacity"
                      },
                      {
                        timeGrain       = null
                        enabled         = "[parameters('metricsEnabled')]"
                        retentionPolicy = {
                          days   = 0
                          enabled = false
                        }
                        category = "Transaction"
                      }
                    ]
                    logs = [
                      { category = "StorageRead", enabled = "[parameters('logsEnabled')]" },
                      { category = "StorageWrite", enabled = "[parameters('logsEnabled')]" },
                      { category = "StorageDelete", enabled = "[parameters('logsEnabled')]" }
                    ]
                  }
                }
              ]
              outputs = {}
            }
            parameters = {
              location      = { value = "[field('location')]" }
              resourceName  = { value = "[field('fullName')]" }
              eventHubRuleId = { value = "[parameters('eventHubRuleId')]" }
              eventHubName  = { value = "[parameters('eventHubName')]" }
              metricsEnabled = { value = "[parameters('metricsEnabled')]" }
              logsEnabled   = { value = "[parameters('logsEnabled')]" }
              profileName   = { value = "[parameters('profileName')]" }
            }
          }
        }
      }
    }
  })
}

resource "azurerm_management_group_policy_assignment" "mg_policy_assignment" {
  name                 = "assign-policy-mg"
  policy_definition_id = azurerm_policy_definition.custom_policy.id
  display_name         = "Assign Custom Policy to Management Group"
  description          = "This policy assignment ensures that all storage accounts under the management group are configured to send logs to the specified Event Hub. This is critical for maintaining visibility into storage account activities and ensuring compliance with organizational logging policies."
  management_group_id  = "/providers/Microsoft.Management/managementGroups/mg-001"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }

  location = var.location

  parameters = jsonencode({
    effect = {
      value = "DeployIfNotExists"
    }
    profileName = {
      value = "setbypolicy_blobDiagSettingsToEventHub"
    }
    metricsEnabled = {
      value = true
    }
    logsEnabled = {
      value = true
    }
    eventHubRuleId = {
      value = azurerm_eventhub_authorization_rule.example.id
    }
    eventHubName = {
      value = var.event_hub_name
    }
    eventHubLocation = {
      value = var.location
    }
  })
}
