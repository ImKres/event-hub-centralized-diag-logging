# Diagnostics and Policy Management
## Overview
This Terraform project sets up an Azure infrastructure that includes an Event Hub for receiving diagnostic logs, a custom Azure Policy for enforcing diagnostic settings, and the associated managed identities and monitoring alerts. The project follows the principles outlined in the Event Hub diagnostics theory provided in the link and ensures that all resources are correctly configured and integrated.

## Resources Used
#### 1. Resource Group (azurerm_resource_group)
- Purpose: This resource defines the Azure Resource Group where all other resources are deployed. It serves as the logical container for the Azure resources.
#### 2. Virtual Network (azurerm_virtual_network)
- Purpose: Provides a secure networking environment for the Azure resources. It is the backbone of the infrastructure's networking setup.
#### 3. Subnet (azurerm_subnet)
- Purpose: Segments the virtual network to provide isolation for different resources. It is associated with the Virtual Machine in this setup.
#### 4. Network Interface (azurerm_network_interface)
- Purpose: Attaches the subnet to the virtual machine, enabling network connectivity within the virtual network.
#### 5. Virtual Machine with System-Assigned Identity (azurerm_virtual_machine)
- Purpose: Creates a Virtual Machine (VM) that uses a system-assigned managed identity. This VM can interact with other Azure services securely without needing embedded credentials.
#### 6. User-Assigned Managed Identity (azurerm_user_assigned_identity)
- Purpose: Creates a user-assigned managed identity that can be explicitly assigned to resources such as policies. It provides a way to control identity across multiple resources.
#### 7. Role Assignments (azurerm_role_assignment)
- Purpose: Assigns necessary roles to the managed identities, ensuring they have the required permissions to interact with the Event Hub and other resources.
#### 8. Event Hub Namespace (azurerm_eventhub_namespace)
- Purpose: Provides a container for the Event Hub, enabling it to receive diagnostic logs. It is the primary messaging entity in Azure.
#### 9. Event Hub (azurerm_eventhub)
- Purpose: A scalable event processing service used to receive diagnostic logs from other Azure services. It is configured to store logs as per the custom policy's requirements.
#### 10. Monitor Action Group (azurerm_monitor_action_group)
- Purpose: Defines a group of actions (like sending emails) triggered by monitoring alerts. This ensures that any significant events related to the Event Hub are promptly notified.
#### 11. Metric Alerts for Event Hub (azurerm_monitor_metric_alert)
- Purpose: Sets up alerts to monitor the health and performance of the Event Hub. Alerts are configured for metrics like incoming requests, throttled requests, active connections, etc.
#### 12. Policy Definition (azurerm_policy_definition)
- Purpose: Defines a custom policy that ensures all Azure Storage Accounts have diagnostics logs sent to a specified Event Hub. This policy is central to enforcing diagnostic logging practices.
#### 13. Policy Assignment with System-Assigned Identity (azurerm_subscription_policy_assignment)
- Purpose: Assigns the custom policy to the subscription using a system-assigned identity. This ensures that the policy is actively applied across the subscription.
#### 14. Policy Assignment with User-Assigned Identity (azurerm_subscription_policy_assignment)
- Purpose: Assigns the custom policy to the subscription using a user-assigned identity, providing more granular control over identity management.

## Theory and Implementation
The configuration is based on the theory provided in the link about receiving diagnostic logs from Storage Accounts into an Event Hub. The key concept is to ensure that all Storage Accounts within the Azure environment send their diagnostics logs to a centralized Event Hub, which then processes and stores these logs for further analysis.

## Key Points from the Theory:
- Centralized Logging: The Event Hub acts as a central repository for diagnostic logs, enabling streamlined monitoring and analysis.
- Custom Policy Enforcement: The Azure Policy is configured to enforce that all Storage Accounts must have diagnostics logs enabled and directed to the Event Hub.
- Managed Identities: Both system-assigned and user-assigned identities are used to securely manage access and ensure that only authorized services can interact with the Event Hub and other resources.

This project implements these concepts using Terraform, ensuring that the entire setup is automated, consistent, and easily repeatable.

## How to Use
#### 1. Initialize Terraform:
`terraform init`

#### 2. Review the Plan:
`terraform plan`

#### 3. Apply the Configuration:
`terraform apply`

4. Monitor Resources: Use the Azure Portal to monitor the Event Hub, view alerts, and check policy assignments.

## Conclusion
This Terraform configuration automates the deployment of a comprehensive Azure infrastructure for centralized diagnostics logging, custom policy management, and resource monitoring. It ensures compliance with best practices for logging and security, following the guidelines provided in the Event Hub diagnostics theory.
