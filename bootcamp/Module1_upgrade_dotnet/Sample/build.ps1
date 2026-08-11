$nuget  = "C:\nuget.exe"
$msbuild = "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
$sln = "eShopLiteFx.sln"

Write-Host "=== Restoring NuGet packages ===" -ForegroundColor Cyan
& $nuget restore $sln
Write-Host "Restore exit: $LASTEXITCODE"

Write-Host "=== Building solution ===" -ForegroundColor Cyan
& $msbuild $sln /p:Configuration=Debug /v:minimal
Write-Host "Build exit: $LASTEXITCODE"
