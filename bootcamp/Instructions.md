# FY 27 Modernization Bootcamp Notes

## Design

- Original [repo](https://github.com/Azure-Samples/modernize-monolith-workshop)
- [regular app](https://github.com/sojorgensen_microsoft/eshoplite-upgrade-sandbox) module 2
- [admin app](https://github.com/sojorgensen_microsoft/eshoplite-admin-sandbox) module 9 

## Setting up your environment

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

## Running application

The sample app is an **ASP.NET MVC 5 / .NET Framework 4.8** project hosted under IIS Express. It uses Entity Framework 6 with a LocalDB database. Follow the steps below to get it running from VS Code without Visual Studio.

### Prerequisites

- Visual Studio 2022 (provides MSBuild and IIS Express)
- `C:\nuget.exe` — download from [nuget.org/downloads](https://www.nuget.org/downloads) if missing
- SQL Server LocalDB (installed with VS 2022 by default)

### Option A — VS Code Tasks (recommended)

The `.vscode/tasks.json` in the `Sample` folder defines the full pipeline.

1. Open VS Code with the workspace rooted at `.NET_Modernization_Workshop`.
2. Press **Ctrl+Shift+P** → **Tasks: Run Task** → select **`iisexpress`**.
   - This automatically triggers the full chain: `nuget-restore` → `build` → `start-localdb` → `iisexpress`.
3. Wait for IIS Express to start (the dedicated terminal shows IIS Express output).
4. Open your browser at **http://localhost:44326**.

To debug with a browser launch, press **F5** and select **"Launch eShopLite (IIS Express)"** — it runs the same task chain then opens Microsoft Edge.

### Option B — Manual steps (PowerShell)

Run the following commands in order from a PowerShell terminal:

**1. Restore NuGet packages**
```powershell
C:\nuget.exe restore "C:\Users\oreakinodidi\.NET_Modernization_Workshop\bootcamp\Module1_upgrade_dotnet\Sample\eShopLiteFx.sln"
```

**2. Build the solution**
```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe" `
  "C:\Users\oreakinodidi\.NET_Modernization_Workshop\bootcamp\Module1_upgrade_dotnet\Sample\eShopLiteFx.sln" `
  /p:Configuration=Debug /v:minimal
```

**3. Start LocalDB** (required for Entity Framework — requests hang without this)
```powershell
sqllocaldb start MSSQLLocalDB
```

**4. Start IIS Express**
```powershell
& "C:\Program Files\IIS Express\iisexpress.exe" `
  /path:"C:\Users\oreakinodidi\.NET_Modernization_Workshop\bootcamp\Module1_upgrade_dotnet\Sample\src\eShopLite.StoreFx" `
  /port:44326 /clr:v4.0
```

**5. Open the app** — navigate to **http://localhost:44326** in your browser.

### Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| HTTP requests time out | LocalDB is stopped | Run `sqllocaldb start MSSQLLocalDB` |
| `MSB4019` build error | `dotnet build` used instead of MSBuild | Use the MSBuild path from VS 2022 above |
| `Element not found` from iisexpress.exe | Custom `applicationhost.config` is incomplete | Use `/path:` instead of `/config:` |
| NuGet packages missing | `msbuild /t:Restore` doesn't work for `packages.config` | Use `C:\nuget.exe restore` |
| IIS Express exits immediately | Port already in use | Run `Stop-Process -Name iisexpress -Force` then retry |

## Module 1: Upgrade with GitHub Copilot Modernization

**GitHub Copilot Modernization** leverages AI to automate and guide the upgrade process, making it easier to upgrade not just the framework, but also transition to modern architectures and technologies.

## What You'll Do

This section covers:

🤖 Using GitHub Copilot for intelligent upgrades  
🔄 Migrating from .NET Framework to .NET 10  
💾 Transitioning from SQL Express to SQLite  
⚡ Converting MVC frontend to Blazor components  
🔧 Troubleshooting common migration issues  

## 🚨 Important note

> If you're working directly from this workshop's repository, please copy the Sample folder to another location before proceeding. The extension will attempt to create branches and git commits to save modifications as it progresses!

## GitHub Copilot Upgrade

GitHub Copilot Modernization works through a three-stage workflow: **Assessment → Planning → Execution**.

- **Assessment:** Copilot analyzes your project structure, dependencies, and code patterns to identify upgrade requirements and potential breaking changes
- **Planning:** The tool generates a detailed upgrade plan document based on assessment findings
- **Execution:** You review the plan, add custom requirements, and Copilot performs the automated upgrade

We're going to upgrade our application to achieve three major goals:

- Upgrade to .NET 10
- Migrate from SQL Express to SQLite
- Transform our MVC frontend to modern Blazor components

### Step 1: Initiate the Upgrade