# Pre-Lab Setup Guide — .NET Modernization Workshop

Complete these steps **before** the hands-on lab begins. The setup takes approximately **45 minutes** and provisions all the Azure resources you will work with throughout the day.

---

## Requirements

Before you start, make sure you have the following in place:

| Requirement | Details |
|---|---|
| Azure subscription | Pay-as-you-go or MSDN. Trial subscriptions will **not** work. |
| Entra ID permissions | You must be able to register applications, create service principals, and assign roles in your Microsoft Entra ID tenant. |
| Subscription permissions | Contributor or Owner on the subscription, plus the ability to register resource providers. |
| Tooling | [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) or access to the [Azure portal](https://portal.azure.com). |

> **Note on unique names**: Many Azure resources require globally unique names. Wherever you see **SUFFIX** in a resource name below, replace it with your initials or another short unique value — for example, `hands-on-lab-ojd`.

---

## Task 1: Create a Resource Group

All lab resources will live in a single resource group, making it easy to manage and clean up at the end.

1. Open the [Azure portal](https://portal.azure.com) and select **Resource groups** from the Azure services list.

2. Select **+ Create**.

3. Fill in the **Basics** tab:

    | Field | Value |
    |---|---|
    | Subscription | Your lab subscription |
    | Resource group | `hands-on-lab-SUFFIX` |
    | Region | Your preferred Azure region (e.g., `East US 2`) |

4. Select **Review + Create**, then **Create** once validation passes.

---

## Task 2: Register Required Resource Providers

Some Azure services need their resource provider registered before they can be deployed. Register the following providers now to avoid delays later.

| Provider | Service it enables |
|---|---|
| `Microsoft.DataMigration` | Azure Database Migration Service |
| `Microsoft.Search` | Azure AI Search |
| `Microsoft.CognitiveServices` | Azure OpenAI Service & Azure AI Document Intelligence |
| `Microsoft.MachineLearningServices` | Azure Machine Learning |

### Steps

1. In the [Azure portal](https://portal.azure.com), navigate to **Subscriptions** and select your lab subscription.

2. Select **Resource providers** from the left menu.

3. For each provider in the table above, search by name, select it, and choose **Register**. Wait for the status to show **Registered** before moving to the next one — this typically takes 1–2 minutes. Use **Refresh** to update the status.

---

## Task 3: Provision Lab Resources via Bicep Template

Rather than creating resources manually, you will deploy a Bicep template that provisions everything needed for the lab in one step. This gives you a consistent, repeatable environment and reflects modern Azure IaC practices.

### Resources provisioned

The template deploys the following resources into your `hands-on-lab-SUFFIX` resource group:

| Resource | Purpose |
|---|---|
| Lab VM (Visual Studio 2022 + SSMS) | Primary development machine for the lab |
| SQL Server 2008 R2 VM + DMA | Simulates the on-premises source database for the migration |
| Azure SQL Database | Target PaaS database for the PolicyConnect migration |
| Azure Database Migration Service | Orchestrates the database migration from SQL Server 2008 R2 |
| Azure App Service Plan + Web App | Hosts the modernized ASP.NET Core 8 PolicyConnect web application |
| Azure App Service (API App) | Hosts the shared REST API layer |
| Azure Blob Storage account | Stores policy documents, replacing the on-premises file server |
| Azure AI Search | Powers semantic and vector search over policy documents |
| Azure AI Document Intelligence | Extracts structured data from broker-submitted PDFs |
| Azure OpenAI Service | Provides the GPT-4o model for the copilot-style chat assistant |
| Azure Service Bus | Handles broker document submission events and workflow routing |
| Azure Logic Apps | Orchestrates automated document processing pipelines |
| Azure Key Vault | Stores all secrets, connection strings, and API keys |
| Microsoft Entra ID App Registrations | Secures all applications and APIs with OAuth 2.0 / OIDC |
| Virtual Network | Provides private networking for VMs and PaaS services |

### Deployment steps

1. Open a terminal and sign in to Azure:

    ```bash
    az login
    az account set --subscription "<your-subscription-id>"
    ```

2. Clone the lab repository (if you haven't already):

    ```bash
    git clone https://github.com/oreakinodidi98/.NET_Modernization.git
    cd .NET_Modernization/Lab/infra
    ```

3. Deploy the Bicep template:

    ```bash
    az deployment group create \
      --resource-group hands-on-lab-SUFFIX \
      --template-file main.bicep \
      --parameters suffix=SUFFIX
    ```

4. The deployment takes approximately **15–20 minutes**. When complete, verify that all resources listed in the table above appear in your resource group in the Azure portal.

> **Tip**: Keep the Azure portal open alongside your terminal throughout the lab — it is the easiest way to inspect resource configurations as you work through each exercise.

---

## What's Next

Once all resources are provisioned and showing a status of **Succeeded**, you are ready to begin the hands-on lab. Start with **Lab Exercise 1: Migrate the PolicyConnect Database to Azure SQL Database**.