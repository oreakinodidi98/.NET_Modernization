# Generate a random number
$RAND = Get-Random

# Set it as an environment variable
$env:RAND = $RAND

# Print the random resource identifier
Write-Output "Random resource identifier will be: $RAND"

#set name suffix
$env:NAME_SUFFIX = "$RAND"
Write-Output "Name suffix set to: $env:NAME_SUFFIX"

# Create short suffix (first 6 characters) for resource names with length limits
$SHORT_SUFFIX = $env:NAME_SUFFIX.Substring(0, [Math]::Min(6, $env:NAME_SUFFIX.Length))

# Set Location
$env:LOCATION = "swedencentral"
Write-Output "Location set to: $env:LOCATION"

# Create a resource group name using the random number
$env:RG_NAME = "rg-modernization-$RAND"
Write-Output "Resource group name: $env:RG_NAME"

# Generate a short random name for user assigned identity (globally unique)
$env:USER_ASSIGNED_IDENTITY_NAME = "modernisation-identity-$RAND"
Write-Output "User assigned identity name: $env:USER_ASSIGNED_IDENTITY_NAME"

# CREATE THE RESOURCE GROUP FIRST!
az group create --name $env:RG_NAME --location $env:LOCATION
Write-Output "Resource group $env:RG_NAME created"

# storage account
$env:STORAGE_ACCOUNT_NAME = "modernisation$SHORT_SUFFIX"
Write-Output "Storage account name: $env:STORAGE_ACCOUNT_NAME"

# create storage account
az storage account create --name $env:STORAGE_ACCOUNT_NAME --resource-group $env:RG_NAME --location $env:LOCATION --sku Standard_LRS --access-tier Hot --kind StorageV2
Write-Output "Storage account $env:STORAGE_ACCOUNT_NAME created"

# Virtual machine name
$env:VM_NAME = "modernisation-vm-$RAND"
Write-Output "Virtual machine name: $env:VM_NAME"

# Create VM with Visual Studio 2019 Community on Windows Server 2019
# Size: Standard D2s v3 | RDP (3389) allowed | No infrastructure redundancy
az vm create `
  --resource-group $env:RG_NAME `
  --name $env:VM_NAME `
  --image "MicrosoftVisualStudio:visualstudio2019community:vs-2019-comm-latest-ws2019:latest" `
  --size Standard_D2s_v3 `
  --admin-username demouser `
  --admin-password "Password.1!!" `
  --nsg-rule RDP `
  --public-ip-sku Standard `
  --location $env:LOCATION
Write-Output "VM $env:VM_NAME created"

# SQL Server 2008 R2 VM name
$env:SQL_VM_NAME = "SqlServer2008"
Write-Output "SQL Server VM name: $env:SQL_VM_NAME"

# Create SQL Server 2008 R2 SP3 Standard on Windows Server 2008 R2
# Size: Standard DS12 v2 | RDP (3389) allowed | No infrastructure redundancy
az vm create `
  --resource-group $env:RG_NAME `
  --name $env:SQL_VM_NAME `
  --image "MicrosoftSQLServer:sql2008r2sp3-ws2008r2sp1:standard:latest" `
  --size Standard_DS12_v2 `
  --admin-username demouser `
  --admin-password "Password.1!!" `
  --nsg-rule RDP `
  --public-ip-sku Standard `
  --location $env:LOCATION
Write-Output "SQL Server VM $env:SQL_VM_NAME created"

# Configure SQL Server settings:
# - Connectivity: Public (Internet) on port 1433
# - SQL Authentication: enabled with demouser / Password.1!!
az sql vm create `
  --name $env:SQL_VM_NAME `
  --resource-group $env:RG_NAME `
  --location $env:LOCATION `
  --connectivity-type PUBLIC `
  --port 1433 `
  --sql-auth-update-username demouser `
  --sql-auth-update-pwd "Password.1!!" `
  --license-type PAYG
Write-Output "SQL Server settings configured for $env:SQL_VM_NAME"