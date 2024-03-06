## Ensures the fact directory is present & populates facts passed to the task
## Author: Ken Meservy

### Need to test whether or not this will over-write the fact files if they
### already exist

# Take parameters from console
[Parameter(Mandatory = $False)]
[String]$AppTier,
[Parameter(Mandatory = $False)]
[String]$Role,
[Parameter(Mandatory = $False)]
[Array]$SoftwareStack
# If there are values present in the facts already, this will need to be set to true.
[Parameter(Mandatory = $False)]
[Boolean]$Override = $False

# Verify the facts directory exists, if it doesn't, create it
$FactsDir = 'C:\ProgramData\puppetlabs\facter\facts.d'

if (Test-Path -Path $FactsDir) {
    Write-Host "Facts Directory Present"
} else {
    New-Item -ItemType "Directory" -Path $FactsDir
}

# Ensure directory is empty, if it isn't, stop here & bubble up the contents of the directory
# This should probably check to see if there are existing facts on the machine,
# then do a check for a force flag or something, if that isn't there & facts exist
# then throw an error and output the existing facts. Maybe I need to learn
# try/catch


# Check $AppTier for null/empty value, if false check for an applicable value,
# and if true create the json object & write it to a file
$AllowedValues = @('development', 'test', 'production')

if ([string]::IsNullOrEmpty($AppTier)) {
    Write-Host "AppTier not supplied"
} elseif ($AppTier -in $AllowedValues ) {
    # Create empty json object
    $FactAppTier = ConvertTo-Json @()
    
    # Add the key/value pair for apptier
    $FactAppTier | Add-Member -MemberType NoteProperty -Name "apptier" -Value $AppTier

    # Write the value out to a file
    Set-Content -Path "($FactsDir)\apptier.json" -Value $FactAppTier
} else {
    Write-Host "Invalid Apptier Value"
}

# Create the role json provided value isn't empty/null
if ([string]::IsNullOrEmpty($Role)) {
    Write-Host "Role not suplied"
}  else {
     $FactRole = ConvertTo-Json @()
     $FactRole | Add-Member -MemberType NoteProperty -Name "role" -Value $Role

     Set-Content -Path "($FactsDir)\role.json" -Value $FactRole
}

# Create the software stack json value as long as it isn't empty or null, just
# in a slightly different way (if it starts true than it does the logic, rather
# than false)
if ($SoftwareStack.count -gt 0) {
    
    $FactSoftwareStack = ConvertTo-Json @()
    $FactSoftwareStack | Add-Member -MemberType NoteProperty -Name 'software_stack' -Value $SoftwareStack

    Set-Content - Path "($FactsDir)\software_stack.json" -Value $FactSoftwareStack
} else {
    Write-Host "Software stack not supplied"
}
