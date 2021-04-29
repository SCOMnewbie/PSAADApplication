############################################################
#################  FrontEnd + Backend App
############################################################


<#
Now that we know how to create an app, let's create a frontend which will be allowed to communicate with a backend application to read company's email in application context.

TBD

Here we will create 2 applications:
- We start by the backend one
    - No redirect(authentication), the API will validate the token
    - Confidential
    - Add secret
    - API Permissions: Mail.ReadBasic
    - Expose API:
        - MyAPI.Mail.ReadBasic
        - Trust the public App (Why not)
- Create a public App related to this backend API
#>

# Declare variables
[GUID]$TenantID = Read-host "What is your tenant Id?"
[GUID]$SubId = Read-host "What is your subscription Id?"

#Declare your backend settings
$BackendSettings = @{
    displayName            = "DemoBackend01"
    requiredResourceAccess = @(
        @{
            resourceAppId  = "00000003-0000-0000-c000-000000000000" #well know graph API
            resourceAccess = @(
                @{
                    id   = "693c5e45-0940-467d-9b8a-1022fb9d42ef" # Role means application mails.readbasic
                    type = "Role" # Other choice is scope = deleguated, Role means application delegation
                }
            )
        }
    )
    api                    = @{
        oauth2PermissionScopes = @(
            @{
                "adminConsentDescription" = "Allow this desktop application to access the backend app on behalf of the signed-in user"
                "adminConsentDisplayName" = "Access this application"
                id                        = $((new-guid).guid) # has to be a unique value
                "isEnabled"               = 'true'
                "type"                    = "User" #Define the consent policy Admin is the other value
                "userConsentDescription"  = "Allow this desktop application to access the backend app on your behalf"
                "userConsentDisplayName"  = "Access this application"
                "value"                   = "user_impersonation"
            }
        )
    }
}


#Don't forget to switch your context again :)
#Connect-AzAccount

$BackendSettingInJson = Convert-SettingsToJson -TemplateSettings $BackendSettings

$token = "Bearer {0}" -f (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com/").Token

#Build App registration
$BackendAppRegistration = New-AppRegistration -AccessToken $token -InputWithVariable $BackendSettingInJson -ConfidentialApp

# Create a secret automatically (valid 2 years)
$BackendAppRegistrationCreds = Add-AppRegistrationPassword -AccessToken $token -ObjectId $BackendAppRegistration.Id

# Create a SP from this App registration
$BackendServicePrincipal = New-ServicePrincipal -AccessToken $token -AppId $BackendAppRegistration.appId

# Create the IdentifierUris
Set-AppRegistrationIdentifierUris -AccessToken $token -ObjectId $BackendAppRegistration.Id -AppId $BackendAppRegistration.AppId

#Now we can create scopes of our custom api
Set-AppRegistrationoauth2PermissionScopes -AccessToken $token -ObjectId $BackendAppRegistration.Id -InputWithVariable $BackendSettingInJson

# Now we have a new backend app with an exposed api generated with random Id. We need to get this value to give it to the Public App !
# Get the scopeIDInfo
$ScopeInfo = Get-APIScopesInfo -AccessToken $token -AppId $BackendAppRegistration.AppId -Deleguated #Because our exposed api is in delegated permission

# Create the public app (Relace with your value for the displayname)

$DesktopSettings = @{
    displayName = 'DemoFrontEnd01'
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
                }
            )
        },
        @{
            resourceAppId = $BackendAppRegistration.AppId #$BackendAppRegistration.appId
            resourceAccess = @(
                @{
                    id = $ScopeInfo.Id #$ScopeInfo.id
                    type = "Scope"
                }
            )
        }
    )
}

#. .\src\Convert-SettingsToJson.ps1
$DesktopSettingsInJson = Convert-SettingsToJson -TemplateSettings $DesktopSettings -Verbose

#Build App registration
$FrontendAppRegistration = New-AppRegistration -AccessToken $token -InputWithVariable $DesktopSettingsInJson

# Create a SP from this App registration
$FrontendServicePrincipal = New-ServicePrincipal -AccessToken $token -AppId $FrontendAppRegistration.appId

# And make sure our app is not available for everyone in our tenant 
Set-ServicePrincipalAppRoleAssignmentRequired -AccessToken $token -ObjectId $FrontendServicePrincipal.Id