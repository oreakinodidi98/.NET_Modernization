# Setting up your environment

This Bootcamp is designed to help you modernize .NET applications. Focussing on everything from modernizing code from .NET Framework to a modern .NET, getting all that code ready for the cloud with microservices and Aspire, and even adding in a sprinkling of AI.

## 📝 Tooling and frameworks needed

- [.NET 10 SDK](https://dotnet.microsoft.com/download/dotnet/10.0) : The latest version of the .NET SDK that you'll need for development.
- [Visual Studio](https://visualstudio.microsoft.com/vs/) with the web workload installed
- [.NET 4.8 Framework](https://dotnet.microsoft.com/download/dotnet-framework/net48): A version of the .NET Framework that the existing application for this workshop is currently using.
- [GitHub Copilot Modernization](https://learn.microsoft.com/dotnet/core/porting/github-copilot-app-modernization/install): Built into Visual Studio 2026 as an optional component. Enable it via the Visual Studio Installer. Assists in migration by providing AI-powered suggestions and automating modernization tasks.
- [SQL Express](https://www.microsoft.com/en-us/download/details.aspx?id=104781&lc=1033&msockid=3bf02f53610f677810c73afb608a66da): A lightweight version of SQL Server for local development and testing.
- [GitHub Copilot Pro](https://github.com/features/copilot): Optional, as you can read through the [update with GitHub Copilot](../2-upgrade-dotnet/2-upgrade-with-ghcp-modernization-app/README.md) section.
- [Docker Desktop](https://docs.docker.com/desktop/)
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) with [Azure Container Apps extension](https://learn.microsoft.com/cli/azure/azure-cli-extensions-list)
- [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/install-azd)
- [Azure subscription](https://signup.azure.com/signup) - this is optional.
- [Visual Studio 2026](https://visualstudio.microsoft.com/vs/) with the **.NET desktop development** workload installed
- [.NET 4.8 Framework](https://dotnet.microsoft.com/download/dotnet-framework/net48): The WinForms starter project targets .NET Framework 4.8.
- A running instance of the **eShopLite Products API** from an earlier module (the WinForms admin tool connects to it). 

> 💡 **IDE Flexibility**
>
> For this workshop choose the IDE you're most comfortable with the core workflow (Assessment → Planning → Execution) is the same.

## Module 1: Upgrade with GitHub Copilot Modernization

**GitHub Copilot Modernization** leverages AI to automate and guide the upgrade process, making it easier to upgrade not just the framework, but also transition to modern architectures and technologies.

## 📋 What You'll Do

This section covers:

🤖 Using GitHub Copilot for intelligent upgrades  
🔄 Migrating from .NET Framework to .NET 10  
💾 Transitioning from SQL Express to SQLite  
⚡ Converting MVC frontend to Blazor components  
🔧 Troubleshooting common migration issues  

## 🚨 Important note

> If you're working directly from this workshop's repository, please copy the StartSample folder to another location before proceeding. The extension will attempt to create branches and git commits to save modifications as it progresses!