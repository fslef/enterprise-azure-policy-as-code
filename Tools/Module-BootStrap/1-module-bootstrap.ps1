if (-not (Get-Module -ListAvailable -Name 'Sampler')) {
    Install-Module -Name 'Sampler' -Scope 'CurrentUser'
}

# by default the root folder is the parent folder of the current script
$epacRepoRootFolder = (Get-Item $PSScriptRoot).Parent.Parent.Parent.FullName

# ask if we shoud continue
$continue = Read-Host -Prompt "The module root folder is: $epacRepoRootFolder Do you want to continue? (Y/N)"
if ($continue -ne 'Y') {
    return
}

$samplerModule = Import-Module -Name Sampler -PassThru

$invokePlasterParameters = @{
    TemplatePath      = Join-Path -Path $samplerModule.ModuleBase -ChildPath 'Templates/Sampler'
    DestinationPath   = $epacRepoRootFolder
    ModuleType        = 'CustomModule'
    ModuleName        = 'enterprise-azure-policy-as-code'
    ModuleAuthor      = 'Microsoft Corporation'
    ModuleDescription = 'Enterprise Azure Policy as Code (EPAC) is a PowerShell module designed to deploy and manage Azure Policies, Policy Sets, Policy Assignments, Policy Exemptions, and Role Assignments. It can be used in CI/CD pipelines or for semi-automated deployments. EPAC also includes scripts to simplify routine operational tasks.'
    LicenseType       = 'MIT'
}

Invoke-Plaster @invokePlasterParameters