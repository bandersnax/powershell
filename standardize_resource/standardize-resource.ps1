## IIS Resource Standardize Script
## Author: Ken Meservy

# Install & import our yaml parser since PowerShell can't do it natively
Install-Module -Name powershell-yaml -Force -Verbose -Scope CurrentUser
Import-Module powershell-yaml

# Store the contents of the files that need to be compared as a string
[string]$default_yaml = Get-Content -Path '.\default.yaml' -Raw
[string]$export_yaml  = Get-Content -Path '.\export.yaml' -Raw

# Convert yaml content into PowerShell objects
$def_obj = ConvertFrom-Yaml $default_yaml -Ordered
$exp_obj  = ConvertFrom-Yaml $export_yaml -Ordered

# Will it compare?
# Compare-Object -ReferenceObject $default_obj.values -DifferenceObject $export_obj.values -IncludeEqual
