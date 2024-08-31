# EventHub Diagnostics Log Receiver
This repository contains the code and instructions for setting up an Azure Event Hub to receive diagnostic logs from Azure Storage Accounts. This is based on the guide provided in the [Azure PaaS Blog.](https://techcommunity.microsoft.com/t5/azure-paas-blog/eventhub-how-to-receive-diagnostic-log-from-storage-accounts-on/ba-p/3928321)

## Overview
The purpose of this project is to automate the process of receiving diagnostic logs from Azure Storage Accounts via Azure Event Hub. The setup involves configuring storage accounts to send diagnostic logs to an Event Hub, which can then be consumed by various applications or services for monitoring, auditing, or other analytical purposes.

## Prerequisites
Before setting up the environment, ensure you have the following:

- Azure Subscription: Required to create and manage Azure resources.
- Azure CLI or Azure PowerShell: For managing Azure resources via command line.
- Terraform: To automate the deployment of Azure resources (if using IaC).
- Visual Studio Code or another code editor: To edit and manage configuration files.

## Setup Instructions
### 1. Clone the Repository
``` bash
git clone https://github.com/yourusername/yourrepository.git
cd yourrepository
```
### 2. Configuring Azure Event Hub
- Follow the instructions provided in the Azure PaaS Blog to set up your Event Hub to receive logs from Storage Accounts.
### 3. Setting Up Storage Account Diagnostics
- Enable Diagnostics: Configure your storage accounts to send diagnostic logs to the Event Hub.
- Log Categories: Ensure that the appropriate categories (e.g., Blob, Table, Queue, etc.) are enabled for diagnostics.
### 4. Deploying with Terraform (Optional)
If you're using Terraform for infrastructure as code (IaC), you can automate the setup process:

Update the terraform.tfvars file with your specific variables, such as subscription ID, resource group, and Event Hub namespace.

Deploy the infrastructure:

``` bash
terraform init
terraform apply
```
### 5. Monitoring and Testing
- Monitor Logs: Use Azure Monitor or a similar service to ensure that logs are being correctly routed to your Event Hub.
- Test Log Reception: Generate some activity in your storage accounts and confirm that the logs are received by the Event Hub.

## Usage
After the setup, the Event Hub will automatically start receiving diagnostic logs from the configured storage accounts. These logs can be consumed by any event consumers configured for the Event Hub, such as Azure Stream Analytics, Azure Functions, or custom applications.

## Troubleshooting
- Logs Not Appearing: Ensure that diagnostic settings are correctly configured on the storage accounts and that the Event Hub is properly set up to receive logs.
- Event Hub Errors: Check the Azure portal for any Event Hub-related errors or misconfigurations.
- Terraform Issues: If using Terraform, ensure that all variables are correctly set and that the Azure resources are available.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue if you find any bugs or have suggestions for improvements.

Acknowledgments
Microsoft Tech Community: For the guide that inspired this project.
Notes:
Replace "https://github.com/yourusername/yourrepository.git" with the actual URL of your repository.
Modify the instructions based on your exact implementation details if they differ from the guide.
Ensure all referenced files and configurations are included in your repository.
This README provides a solid foundation for understanding and using your code base, while also allowing others to contribute effectively.
