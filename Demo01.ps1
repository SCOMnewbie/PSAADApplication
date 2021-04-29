#region RBAC 

############################################################
#################  CREATE RBAC ACCOUNT
############################################################

<#
As I've explained before, the CLI give you unnecessary configuration when you do: az ad sp create-for-rbac ...
In this demo, we will do:
- Confidential app registration for RBAC usage
- generate a secret for it
- Enabled a service principal
- Do a role assignment on a resource group
- connect with the SP
- get all resource group of the sub

#>

# Declare variables
[GUID]$TenantID = Read-host "What is your tenant Id?"
[GUID]$SubId = Read-host "What is your subscription Id?"
[string]$RGName = Read-host "What is your resource group name?"   # Use to assign roles for the demo, we will remove it at the end of the demo
$Scope = "/subscriptions/$SubId/resourceGroups/$RGName" # Make sure it's created


#Define your settings
$RBACsettings = @{
    displayName = "DemoRBAC01"
}

$RBACsettingsJson = Convert-SettingsToJson -TemplateSettings $RBACsettings

# Generate an AT for the graph audience (check previous article for more info)
$token = "Bearer {0}" -f (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com/").Token

#To validate we have a token and avoid doxing :p
$token.Length

#Build App registration
$RBAC01AppRegistration = New-AppRegistration -AccessToken $token -InputWithVariable $RBACsettingsJson  -ConfidentialApp
# Create a secret automatically (valid 2 years)
$RBAC01AppRegistrationCreds = Add-AppRegistrationPassword -AccessToken $token -ObjectId $RBAC01AppRegistration.Id
# Create an identity for our App
$RBAC01ServicePrincipal = New-ServicePrincipal -AccessToken $token -AppId $RBAC01AppRegistration.appId

# Now we can use it for role assignment (may wait few seconds)
New-AzRoleAssignment  -RoleDefinitionName Reader -ResourceGroupName $RGName -ApplicationId $RBAC01AppRegistration.appId

#Connect with the SP
Start-Sleep -Seconds 10 # Waiting for AAD to replicate the change
$pwd = ConvertTo-SecureString $RBAC01AppRegistrationCreds.secretText -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential($RBAC01AppRegistration.appId,$pwd)
Connect-AzAccount -Tenant $TenantID -Subscription $subId -Credential $creds -ServicePrincipal

# Validate the access
Get-AzContext
# And here you should see only one RG
Get-AzResourceGroup

#endregion 
