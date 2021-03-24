Throw "no F5, this is a demo"

<#

The goal of this demo is to demonstrate how we can create and configure our App registration without any dependency (Pullumi, Terraform). 
Pre requisites:
- Az Powershell module
- Az CLI

Make sure you're connected with a account which can create both Resource group and Application (application admin + Sub access for example)

It's still a work in progress, I don't know if yes or no I should convert it to a Powershell gallery module

#>



# Declare variables

[GUID]$TenantID = Read-host "What is your tenant Id?"
[GUID]$SubId = Read-host "What is your subscription Id?"
[string]$RGName = Read-host "What is your resource group name?"   # Use to assign roles for the demo, we will remove it at the end of the demo
$Scope = "/subscriptions/$SubId/resourceGroups/$RGName" # Make sure it's created

# Are you connected?
az account show #Az CLI
Get-AzContext  #Powershell Az

# Is RG created?
az group create -n $RGName -l 'eastus'  # why not eastUS


#Load functions in memory
$Functions = @( Get-ChildItem -Path ".\src\*.ps1" -ErrorAction SilentlyContinue )
Foreach ($Function in $Functions) {
    Try {
         . $Function.fullname
    }
    catch{
        Write-Error "Unable to load functions"
    }
}

$Functions.count

#region RBAC 

############################################################
#################  CREATE RBAC ACCOUNT
############################################################

# Here a command you're used to see:
$MyCLISP = az ad sp create-for-rbac -n "CLIWay" --role Reader --scopes $Scope

<#
# Let's look at the portal and look at what has been created:
- Under Authentication:
    > NOTE: You have implicit grant and/or logout URI settings set without any Web or SPA redirect URIs registered. You should remove these settings or register the appropriate redirect URI.
    > Why ID Token implicit is enabled? This is a "dummy" SP?
- Under Expose an API:
    > A user_impersonation scope is enabled, I'm not sure to understand why
    > And you also have a Unique URI Id (http://CLIWay)
-Manifest:
    > No token version means V1
#>

# Create a new account with the least privilege idea

#All our applications need a nale
$DisplayName = "DemoSimpleRBAC01"

#Make sure here you've proper defined the template you want to use. (This part has to be improved)
#Re-generate the script to avoid legacy copy/paste.
. .\src\Convert-SettingsToJson.ps1
Convert-SettingsToJson -DisplayName $DisplayName -OutputFolder ".\Output"

# Generate an AT for the graph audience (check previous article for more info)
$token = "Bearer {0}" -f (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com/").Token

#To validate we have a token and avoid doxing :p
$token.Length

#Build App registration
$RBAC01AppRegistration = New-AppRegistration -AccessToken $token -ConfigFilePath ".\Output\$DisplayName.json" -ConfidentialApp
# Create a secret automatically (valid 2 years)
$RBAC01AppRegistrationCreds = Add-AppRegistrationPassword -AccessToken $token -ObjectId $RBAC01AppRegistration.Id
# Create an identity for our App
$RBAC01ServicePrincipal = New-ServicePrincipal -AccessToken $token -AppId $RBAC01AppRegistration.appId

# Now we can use it for role assignment
New-AzRoleAssignment  -RoleDefinitionName Reader -ResourceGroupName $RGName -ApplicationId $RBAC01AppRegistration.appId

#Connect with the SP
Start-Sleep -Seconds 10 # Waiting for AAD to replicate the change
$pwd = ConvertTo-SecureString $RBAC01AppRegistrationCreds.secretText -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential($RBAC01AppRegistration.appId,$pwd)
Connect-AzAccount -Tenant $TenantID -Subscription $subId -Credential $creds -ServicePrincipal

# Validate the access
Get-AzContext
Get-AzResourceGroup

#Check app properties and compare

$CLIWayObjectId = (Get-AppRegistrationPropertiesFromIdentifierUris -AccessToken $token -IdentifierUris "http://CLIWay").Id
$CLiWayAppProperties = Get-AppRegistrationproperties -AccessToken $token -ObjectId $CLIWayObjectId
$CLiWayAppProperties 
$CLiWayAppProperties.web  # web + unique Id URI
$CLiWayAppProperties.web.implicitGrantSettings  # implicit
$CLiWayAppProperties.api #Token version + Oauth2permission


$DemoRBACAppProperties = Get-AppRegistrationproperties -AccessToken $token -ObjectId $RBAC01AppRegistration.Id
$DemoRBACAppProperties
$DemoRBACAppProperties.web
$DemoRBACAppProperties.api

<#
SUMMARY: 
- unnecessary permission, so why not doing this way?
- IdentifierUris can be interesting if you plan to test if yes or no your application exist already (see below) 
#>

############################################################
############################################################
############################################################

#endregion 

#region DesktopApp01

############################################################
#################  Desktop App 01
############################################################

#Don't forget to switch your context again :)
Connect-AzAccount

# Imagine we create an app to list which groups we own. 
# IMPORTANT: Here we will just create the app, later we will play with it with tokens

# NOTE: To help to find the scope Id, you can use the cmdlet Get-GraphAPIScopesInfo -AccessToken $token -ScopeKeyword "group"

#Check Templates/DemoDesktopApp01.ps1

$DisplayName = "DemoDesktopApp01"

#Template DemoDesktopApp01
#Re-generate the script to avoid legacy copy/paste.
. .\src\Convert-SettingsToJson.ps1
Convert-SettingsToJson -DisplayNAme $DisplayName -OutputFolder ".\Output"

$token = "Bearer {0}" -f (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com/").Token

#Build App registration
# No confidentialApp this time
$Desktop01AppRegistration = New-AppRegistration -AccessToken $token -ConfigFilePath ".\Output\$DisplayName.json"
# IMPORTANT: No secret this time, this is a public app !

# Create a SP from this App registration (No need password, it's a public app)
$Desktop01ServicePrincipal = New-ServicePrincipal -AccessToken $token -AppId $Desktop01AppRegistration.appId

<#
SUMMARY:
- Public App
- Redirect URI already defined
- SP defined
- Token V2
- Single Tenant
- Api permissions for our specific need. Now GA can consent for it.


#>
############################################################
############################################################
############################################################

#endregion


#region DesktopApp02

############################################################
#################  Desktop App 02
############################################################

<#
Here we will raise the bar. 
- The Desktop app will discuss with a backend app.
- The backend App will simply count the number of groups the user belongs based on the Access Token provided. 
- We would like to expose the ipaddress of the caller in the ID Token
- Only specific people can use this app
#>


#Check Templates/DemoDesktopApp02.ps1

$DisplayName = "DemoDesktopApp02"

#Template DemoDesktopApp02
#Re-generate the script to avoid legacy copy/paste.
. .\src\Convert-SettingsToJson.ps1
Convert-SettingsToJson -DisplayNAme $DisplayName -OutputFolder ".\Output"

$token = "Bearer {0}" -f (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com/").Token

#Still a public App
$Desktop02AppRegistration = New-AppRegistration -AccessToken $token -ConfigFilePath ".\Output\$DisplayName.json"
# Create a secret automatically (valid 2 years)
# Create a SP from this App registration (No need password, it's a public app)
$Desktop02ServicePrincipal = New-ServicePrincipal -AccessToken $token -AppId $Desktop02AppRegistration.appId

# User has now to be assign first before using this app (open portal)
Set-ServicePrincipalAppRoleAssignmentRequired -AccessToken $token -ObjectId $Desktop02ServicePrincipal.id

############################################################
############################################################
############################################################

#endregion


#region SPA01

############################################################
#################  SPA app 01
############################################################

# Find a scenario with what Michael Zanatta presented during the PSConf 2020
# https://www.youtube.com/watch?v=8io4Xv4o3fY&ab_channel=PNWPSUG

$DisplayName = "DemoSpaApp01"

#Check Templates/DemoSpaApp01.ps1
#Re-generate the script to avoid legacy copy/paste.
. .\src\Convert-SettingsToJson.ps1
Convert-SettingsToJson -DisplayNAme $DisplayName -OutputFolder ".\Output"

$token = "Bearer {0}" -f (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com/").Token

#Build App registration (still public)
$SPA01AppRegistration = New-AppRegistration -AccessToken $token -ConfigFilePath ".\Output\$DisplayName.json"
# Create a secret automatically (valid 2 years)
# Create a SP from this App registration (No need password, it's a public app)
$SPA01NewServicePrincipal = New-ServicePrincipal -AccessToken $token -AppId $SPA01AppRegistration.appId

Set-ServicePrincipalAppRoleAssignmentRequired -AccessToken $token -ObjectId $SPA01NewServicePrincipal.id

<#
SUMMARY:
- public app
- implicit flow disabled
- Redirect with spa properties
#>


############################################################
############################################################
############################################################

#endregion

#region Web01

############################################################
#################  Web app 01
############################################################

# All cursor to the right for "fun". We will play with those in the next article(s)
<#
Here we will have:
- A web app with a secret
- scopes are exposed
- declare a IdentifierUris for both scopes exposition + test detection (Get-AppRegistrationPropertiesFromIdentifierUris)
- Add a logo to the app
- people has to be assigned
- Add various claims in both tokens (ID + AT)
- And AppRole because why not
#>

$DisplayName = "DemoWebApp01"

#Check Templates/DemoWebApp01.ps1
#Re-generate the script to avoid legacy copy/paste.
. .\src\Convert-SettingsToJson.ps1
Convert-SettingsToJson -DisplayNAme $DisplayName -OutputFolder ".\Output"

$token = "Bearer {0}" -f (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com/").Token

#Build App registration
$WebApp01AppRegistration = New-AppRegistration -AccessToken $token -ConfigFilePath ".\Output\$DisplayName.json" -ConfidentialApp

# Create a secret automatically (valid 2 years)
$WebApp01AppRegistrationCreds = Add-AppRegistrationPassword -AccessToken $token -ObjectId $WebApp01AppRegistration.Id
# Create a SP from this App registration
$WebApp01ServicePrincipal = New-ServicePrincipal -AccessToken $token -AppId $WebApp01AppRegistration.appId
# Create the IdentifierUris
Set-AppRegistrationIdentifierUris -AccessToken $token -ObjectId $WebApp01AppRegistration.Id -AppId $WebApp01AppRegistration.AppId
#Now we can create scopes of our custom api
Set-AppRegistrationoauth2PermissionScopes -AccessToken $token -ObjectId $WebApp01AppRegistration.Id -ConfigFilePath ".\Output\$DisplayName.json"
# App can have the same displayname, here how to can target your specific app without the appId/ObjectId > if([string]::IsNullOrEmpty($AppRegistration)){...
Get-AppRegistrationPropertiesFromIdentifierUris -AccessToken $token  -IdentifierUris "api://$($WebApp01AppRegistration.appId)"
# Let's now add our logo
Add-AppRegistrationLogo -AccessToken $token -ObjectId $WebApp01AppRegistration.Id -LogoPath ".\ScomNewbie_logo.png"
# And make sure our app is not available for everyone in our tenant 
Set-ServicePrincipalAppRoleAssignmentRequired -AccessToken $token -ObjectId $WebApp01ServicePrincipal.Id

# Open the portal and verify all attributes

############################################################
############################################################
############################################################

#endregion

# Clean the demo

Remove-AppRegistration -AccessToken $token -ObjectId $CLIWayObjectId
Remove-AppRegistration -AccessToken $token -ObjectId $RBAC01AppRegistration.Id
Remove-AppRegistration -AccessToken $token -ObjectId $Desktop01AppRegistration.Id
Remove-AppRegistration -AccessToken $token -ObjectId $Desktop02AppRegistration.Id
Remove-AppRegistration -AccessToken $token -ObjectId $SPA01NewServicePrincipal.Id
Remove-AppRegistration -AccessToken $token -ObjectId $WebApp01AppRegistration.Id
az group delete -n $RGName -y
