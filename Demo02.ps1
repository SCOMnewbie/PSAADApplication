#region DesktopApp01

############################################################
#################  Desktop App 01
############################################################

<#
In this demo, we will do:
- Create a pubic application with generic redirectURI
- Make sure this app can read group in deleguated permission (Of course admin has to grant consent)
- Enabled a service principal where everyone within the tenant will be able to use it.
- Declare the IdentifierUris
- Enforce the user assign requirement in the enterprise App
- Add a logo to the app with a local png
- Make sure the token endpoint is in V2 (internal pre-requisite)
- Single tenant (internal pre-requisite)
#>

Import-Module .\PSAADApplication.psd1

# Declare variables
[GUID]$TenantID = Read-host "What is your tenant Id?"
[GUID]$SubId = Read-host "What is your subscription Id?"

$Desktop01settings = @{
    displayName = "DemoDesktop01"
    publicClient = @{
        redirectUris= @(
            "https://login.microsoftonline.com/common/oauth2/nativeclient"  # Array here can have multiple values
        )
    }
    requiredResourceAccess = @(
        @{
            resourceAppId = "00000003-0000-0000-c000-000000000000" #well know graph API
            resourceAccess = @(
                @{
                    id = "37f7f235-527c-4136-accd-4a02d197296e" #openId scope  To get a clientID https://docs.microsoft.com/fr-fr/azure/active-directory/develop/v2-permissions-and-consent#openid
                    type = "Scope"  # Can be an Role  https://docs.microsoft.com/fr-fr/graph/api/resources/resourceaccess?view=graph-rest-1.0
                },
                @{
                    id = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182" # offline_access scope > To get a Refresh token : https://docs.microsoft.com/fr-fr/azure/active-directory/develop/v2-permissions-and-consent#offline_access
                    type = "Scope"
                },
                @{
                    id = "5f8c59db-677d-491f-a6b8-5f174b11ec1d" # Group.Read.All  Thx Get-APIScopesInfo -AccessToken $token -ScopeKeyword "group"
                    type = "Scope"
                }
            )
        }
    )
}

#Don't forget to switch your context again :)
#Connect-AzAccount

$Desktop01SettingsJson = Convert-SettingsToJson -TemplateSettings $Desktop01settings

# Generate an AT for the graph audience (check previous article for more info)
$token = "Bearer {0}" -f (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com/").Token

#To validate we have a token and avoid doxing :p
$token.Length

#Build App registration
$Desktop01AppRegistration = New-AppRegistration -AccessToken $token -InputWithVariable $Desktop01SettingsJson #Will be public by default

# IMPORTANT: No secret this time, this is a public app !

# Create a SP from this App registration (No need password, it's a public app)
$Desktop01ServicePrincipal = New-ServicePrincipal -AccessToken $token -AppId $Desktop01AppRegistration.appId

# Create the IdentifierUris
Set-AppRegistrationIdentifierUris -AccessToken $token -ObjectId $Desktop01AppRegistration.Id -AppId $Desktop01AppRegistration.AppId

#Make sure user requirement is mandatory now (in the Enterprise App)
Set-ServicePrincipalAppRoleAssignmentRequired -AccessToken $token -ObjectId $Desktop01ServicePrincipal.id

# Let's now add our logo
Add-AppRegistrationLogo -AccessToken $token -ObjectId $Desktop01AppRegistration.Id -LogoPath ".\ScomNewbie_logo.png" -verbose

# Open the portal and check


#endregion