# .NET Modernization Workshop

A hands-on workshop that guides you through migrating and modernizing legacy .NET applications to cloud-native solutions on Azure — including AI-powered features secured with Microsoft Entra ID.

## What You Will Learn

- The end-to-end steps involved in modernizing a legacy .NET application and its underlying infrastructure using Azure managed services
- How to lift and shift a Windows Forms application while progressively introducing cloud-native patterns
- How to enhance existing applications with Azure AI services — including document intelligence, intelligent search, and copilot-style chat experiences
- How to secure all services and APIs with Microsoft Entra ID using passwordless, zero-trust principles
- How to design and implement a modernization roadmap for organizations moving workloads from on-premises to the cloud

## Workshop Format

| Component | Description |
|---|---|
| Whiteboard Design Session | Architecture discussions and modernization planning |
| Hands-On Lab | Step-by-step implementation exercises on Azure |

---

## Customer Scenario

### Background

**Contoso, Ltd.** (Contoso) is an insurance company founded in California in 2010. They provide long-term insurance services to under-insured individuals, filling a gap their founders identified in the market. From the outset, they grew faster than anticipated adding over 150 employees in their first year alone to keep up with demand.

To manage policies and associated documentation, Contoso built a custom **Windows Forms application called PolicyConnect**. PolicyConnect relies on:

- An **on-premises SQL Server 2008 R2** database as its primary data store
- A **local file server** for storing policy documents

Both the application and its underlying processes have become increasingly overloaded as the business has scaled.

### Current State

Contoso has begun a modernization initiative. They recently built a prototype **ASP.NET Core MVC web application** (originally targeting .NET Core 2.2, now targeted for upgrade to .NET 8) that exposes policy data via REST APIs. The goals for this API layer are:

- Allow policyholders, brokers, and employees to access policy information **without a VPN**
- Serve as a **shared API layer** across the web application, mobile app, and the existing WinForms client
- Be hosted and scaled in the **Azure cloud**

The WinForms application will remain in use on-premises for the foreseeable future but will be updated to consume the new cloud-hosted APIs.

### Modernization Goals

Contoso wants to take their modernization further across four key areas:

#### 1. Infrastructure & Platform Migration

- Migrate the on-premises **SQL Server 2008 R2** database to **Azure SQL Database** (PaaS), taking advantage of built-in high availability, automated backups, and Advanced Threat Protection
- Migrate policy document storage to **Azure Blob Storage**, making documents accessible securely from the web and mobile applications
- Host the ASP.NET Core web application and APIs on **Azure App Service** or **Azure Container Apps**, with CI/CD pipelines via **Azure DevOps** or **GitHub Actions**
- Upgrade the application runtime to **.NET 8 (LTS)** to benefit from modern performance improvements and long-term support

#### 2. Application Modernisation

- Refactor the monolithic ASP.NET Core application toward a **modular, API-first design** suitable for future microservices evolution
- Implement **automated document forwarding from brokers** using **Azure Logic Apps** or **Azure Service Bus** to trigger workflows when new policy documents are submitted
- Build the **PolicyConnect mobile application** for iOS and Android using **.NET MAUI**, sharing business logic and consuming the same REST APIs as the web application

#### 3. Security & Identity

- Replace username/password authentication with **Microsoft Entra ID** (formerly Azure Active Directory) for all applications and APIs
- Implement **role-based access control (RBAC)** for policyholders, brokers, and internal employees using Entra ID app registrations and managed identities
- Use **Azure Key Vault** for secrets management, eliminating hardcoded credentials and connection strings
- Apply **passwordless authentication** across services using managed identities for Azure resource-to-resource communication

#### 4. AI Enrichment

Contoso recognises that a cloud migration is an opportunity to embed intelligence into their workflows. They want to add the following AI capabilities using **Azure AI services** and **Azure OpenAI Service**:

| Capability | Azure Service | Use Case |
|---|---|---|
| Intelligent document processing | Azure AI Document Intelligence | Automatically extract structured data (policy numbers, dates, coverage amounts) from broker-submitted PDFs and scanned forms |
| Semantic policy search | Azure AI Search | Enable policyholders and brokers to search policy content using natural language rather than exact keyword matches |
| Copilot-style chat assistant | Azure OpenAI Service (GPT-4o) | Provide an in-app AI assistant that answers policyholder questions about their coverage, claims history, and renewal options using Retrieval-Augmented Generation (RAG) over policy documents |
| Automated document classification | Azure AI Document Intelligence + Custom Models | Classify incoming broker documents by type (new policy, amendment, claim) and route them to the correct workflow automatically |
| Anomaly detection on claims | Azure Machine Learning | Identify suspicious or anomalous claims patterns to support fraud detection workflows |

All AI features will be secured behind Entra ID and exposed through the shared REST API layer, ensuring consistent governance across web, mobile, and desktop clients.

### Success Criteria

By the end of the modernization, Contoso expects to achieve:

- **Zero VPN dependency** for external users accessing policy information
- **Cloud-native scalability** — no manual infrastructure management for the web and API tiers
- **Automated document workflows** — brokers submit documents that are classified, parsed, and routed without manual intervention
- **AI-powered self-service** — policyholders can ask natural language questions about their policies via the web and mobile apps
- **Unified identity** — all access governed by Microsoft Entra ID with no shared secrets or passwords stored in application code
- **Modern .NET stack** — all new development on .NET 8+, with a path to .NET MAUI for mobile

---

## Whiteboard Design Session

In the whiteboard design session, you will work in a group to architect a modernization solution for Contoso's PolicyConnect platform. Starting from the current on-premises state, your group will collaboratively design a target-state architecture that covers infrastructure migration, application modernisation, AI enrichment, and identity.

Topics covered include:

- Selecting the right Azure compute targets for the web application and APIs (Azure App Service vs. Azure Container Apps)
- Designing the database migration path from SQL Server 2008 R2 to Azure SQL Database
- Planning a RAG-based AI assistant using Azure OpenAI Service and Azure AI Search over policy documents
- Designing automated broker document workflows with Azure AI Document Intelligence, Azure Service Bus, and Logic Apps
- Applying a zero-trust identity model using Microsoft Entra ID, managed identities, and Azure Key Vault across all tiers
- Defining a CI/CD strategy with Azure DevOps or GitHub Actions for the web, API, and .NET MAUI mobile application

By the end of the session, your group will have produced a reference architecture and modernization roadmap for Contoso that can be used to guide the hands-on lab.

## Hands-On Lab

The hands-on lab guides you step-by-step through implementing the modernization plan designed in the whiteboard session. Working against a real Azure subscription, you will migrate, upgrade, and enhance the PolicyConnect application across all four modernization tracks.

Lab exercises include:

- **Upgrading** the ASP.NET Core application from .NET Core 2.2 to .NET 8 and deploying it to Azure App Service or Azure Container Apps
- **Migrating** the on-premises SQL Server 2008 R2 database to Azure SQL Database using the Azure Database Migration Service
- **Securing** the application with Microsoft Entra ID — configuring app registrations, RBAC roles, and managed identities to eliminate all hardcoded credentials via Azure Key Vault
- **Storing** policy documents in Azure Blob Storage and updating the application to read and write from cloud storage
- **Adding AI** — integrating Azure AI Document Intelligence to extract data from broker-submitted documents, and building a copilot-style chat feature using Azure OpenAI Service with RAG over an Azure AI Search index
- **Automating workflows** — configuring Azure Service Bus and Logic Apps to route incoming broker documents to the correct processing pipeline
- **Building mobile** — scaffolding the PolicyConnect .NET MAUI app for iOS and Android, consuming the same secured REST APIs as the web application

By the end of the lab, you will have a fully modernized, cloud-native PolicyConnect solution running on Azure — enhanced with AI capabilities and secured end-to-end with Microsoft Entra ID.

---
## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        Azure Cloud                              │
│                                                                 │
│  ┌─────────────┐   ┌──────────────────┐   ┌─────────────────┐  │
│  │ Azure App   │   │  Azure SQL       │   │  Azure Blob     │  │
│  │ Service /   │──▶│  Database        │   │  Storage        │  │
│  │ Container   │   │  (PolicyConnect  │   │  (Policy Docs)  │  │
│  │ Apps        │   │   DB)            │   │                 │  │
│  └──────┬──────┘   └──────────────────┘   └────────┬────────┘  │
│         │                                           │           │
│         │          ┌──────────────────┐             │           │
│         │          │  Azure OpenAI    │             │           │
│         └─────────▶│  Service (RAG /  │◀────────────┘           │
│                    │  Copilot Chat)   │                         │
│                    └──────────────────┘                         │
│                                                                 │
│  ┌─────────────┐   ┌──────────────────┐   ┌─────────────────┐  │
│  │  Azure AI   │   │  Azure AI Search │   │  Azure Service  │  │
│  │  Document   │──▶│  (Semantic /     │   │  Bus / Logic    │  │
│  │  Intelligence│   │   Vector Search) │   │  Apps           │  │
│  └─────────────┘   └──────────────────┘   └─────────────────┘  │
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  Microsoft Entra ID  (Identity & Access for all tiers)   │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘

On-Premises
┌─────────────────────────────┐
│  PolicyConnect WinForms App │──▶ REST APIs (Azure App Service)
│  (updated to use cloud APIs)│
└─────────────────────────────┘

Mobile (.NET MAUI)
┌─────────────────────────────┐
│  iOS / Android App          │──▶ REST APIs (Azure App Service)
└─────────────────────────────┘
```

---

## Technology Stack

| Layer | Current State | Target State |
|---|---|---|
| Desktop App | WinForms (.NET Framework) | WinForms updated to call cloud APIs |
| Web App | ASP.NET Core 2.2 MVC | ASP.NET Core 8 on Azure App Service / Container Apps |
| Mobile App | None | .NET MAUI (iOS & Android) |
| Database | SQL Server 2008 R2 (on-prem) | Azure SQL Database |
| Document Storage | On-prem file server | Azure Blob Storage |
| Authentication | Custom / no SSO | Microsoft Entra ID |
| Document Processing | Manual | Azure AI Document Intelligence |
| Search | Basic SQL full-text | Azure AI Search (semantic + vector) |
| AI Assistant | None | Azure OpenAI Service (RAG-based chat) |
| Messaging / Workflows | None | Azure Service Bus + Logic Apps |
| Secrets Management | Hardcoded config | Azure Key Vault + Managed Identity |
| CI/CD | Manual deployment | Azure DevOps / GitHub Actions |