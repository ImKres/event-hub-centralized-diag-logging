variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-example-eventhub-01"
}

variable "location" {
  description = "The Azure location for resources"
  type        = string
  default     = "eastus"
}

variable "action_group_email" {
  description = "Email for action group notifications"
  type        = string
  default     = "example@example.com"
}

variable "event_hub_name" {
  description = "The name of the Event Hub"
  type        = string
  default     = "example-eventhub"
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "event_hub_sku" {
  description = "The SKU of the Event Hub"
  type        = string
  default     = "Standard"
}

variable "event_hub_capacity" {
  description = "The capacity of the Event Hub"
  type        = number
  default     = 1
}

variable "event_hub_partition_count" {
  description = "The partition count of the Event Hub"
  type        = number
  default     = 2
}

variable "event_hub_message_retention" {
  description = "The message retention of the Event Hub in days"
  type        = number
  default     = 1
}

variable "incoming_messages_threshold" {
  description = "Threshold for incoming messages before triggering alert"
  type        = number
  default     = 1000
}

variable "outgoing_messages_threshold" {
  description = "Threshold for outgoing messages before triggering alert"
  type        = number
  default     = 1000
}

variable "throttled_requests_threshold" {
  description = "Threshold for throttled requests before triggering alert"
  type        = number
  default     = 1
}

variable "active_connections_threshold" {
  description = "Threshold for active connections before triggering alert"
  type        = number
  default     = 1
}

variable "create_policy" {
  description = "Set to true to create the policy, false to skip."
  type        = bool
  default     = true
}

variable "event_hub_rule_id" {
  description = "The ID of the Event Hub authorization rule"
  type        = string
  default     = ""
}
