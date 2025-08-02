[CmdletBinding(PositionalBinding = $false)]
param(
    [ValidateSet("net8.0", "net9.0")]
    [string] $Framework = "net9.0"
)

dotnet build
if ($LASTEXITCODE -ne 0) { throw "build error" }

Write-Host "Launching samples with framework $Framework"

Start-Process `
    -FilePath powershell.exe `
    -ArgumentList @( "dotnet run -f $Framework --no-build; Read-Host 'Press enter to exit'" ) `
    -WorkingDirectory "samples\$Framework\CustomersApi"

Start-Sleep -Seconds 2

Start-Process `
    -FilePath powershell.exe `
    -ArgumentList @( "dotnet run -f $Framework --no-build; Read-Host 'Press enter to exit'" ) `
    -WorkingDirectory "samples\$Framework\OrdersApi"

Start-Sleep -Seconds 5

Start-Process `
    -FilePath powershell.exe `
    -ArgumentList @( "dotnet run -f $Framework --no-build; Read-Host 'Press enter to exit'" ) `
    -WorkingDirectory "samples\$Framework\FrontendWeb"

Start-Process `
    -FilePath powershell.exe `
    -ArgumentList @( "dotnet run -f $Framework --no-build; Read-Host 'Press enter to exit'" ) `
    -WorkingDirectory "samples\$Framework\TrafficGenerator"
