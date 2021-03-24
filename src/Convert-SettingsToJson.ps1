<#
.SYNOPSIS
This function will compile and convert your settings in a json file.
.DESCRIPTION
This function will compile and convert your settings in a json file. The goal here is mainly to generate displayname and GUID on the fly.

.PARAMETER DisplayName
Specify the displayame of your app registration
.PARAMETER OutputFolder
Specify where the json will be generated

.EXAMPLE
Convert-SettingsToJson -DisplayName "MyWebApp01" -OutputFolder "C:\TEMP"

Will generate settings in json format in the C:\TEMP folder.
.NOTES
VERSION HISTORY
1.0 | 2021/03/22 | Francois LEON
    initial version
POSSIBLE IMPROVEMENT
    -
#>
Function Convert-SettingsToJson {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [string]$DisplayName,
        [parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ })]
        [string]$OutputFolder
    )

    # This is where you should define your settings.
    # You can copy/Paste from the templates in to the Templates folder

    
# Template to generate a simple Desktop app where the app can contact the Graph API to generate refresh tokens and you can read groups in delegated mode.

# Template to generate a simple Desktop app where the app can contact the Graph API to generate refresh tokens and you can read groups in delegated mode.
$settings = @{
    displayName            = $DisplayName
    web                    = @{
        homePageUrl           = "https://MyAwesomeWebApp01"
        logoutUrl             = "https://MyAwesomeWebApp01/logout"
        redirectUris          = @(
            "https://MyAwesomeWebApp01:5050"
        )
        implicitGrantSettings = @{
            enableIdTokenIssuance     = "false"
            enableAccessTokenIssuance = "false"
        }
    }
    requiredResourceAccess = @(
        @{
            resourceAppId  = "00000003-0000-0000-c000-000000000000" #well know graph API
            resourceAccess = @(
                @{
                    id   = "37f7f235-527c-4136-accd-4a02d197296e" #openId scope  To get a clientID https://docs.microsoft.com/fr-fr/azure/active-directory/develop/v2-permissions-and-consent#openid
                    type = "Scope"  # Can be an Role  https://docs.microsoft.com/fr-fr/graph/api/resources/resourceaccess?view=graph-rest-1.0
                },
                @{
                    id   = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182" # offline_access scope > To get a Refresh token : https://docs.microsoft.com/fr-fr/azure/active-directory/develop/v2-permissions-and-consent#offline_access
                    type = "Scope"
                },
                @{
                    id   = "5f8c59db-677d-491f-a6b8-5f174b11ec1d" # Group.Read.All  Thx Get-GraphAPIScopesInfo -AccessToken $token -ScopeKeyword "group"
                    type = "Scope"
                }
            )
        }
    )
    appRoles               = @(
        @{
            allowedMemberTypes = @("User")
            description        = "Should be the default role"
            displayName        = "Basic Role"
            id                 = $((new-guid).guid) # has to be a unique value
            isEnabled          = "true"
            value              = "Basic_Role"
        },
        @{
            allowedMemberTypes = @("User")
            description        = "This is an admin role"
            displayName        = "Admin Role"
            id                 = $((new-guid).guid) # has to be a unique value
            isEnabled          = "true"
            value              = "Admin_Role"
        }
    )
    optionalClaims = @{
        idToken = @(
            @{
                "name"= "auth_time" # Provide last auth time
            },
            @{
                "name"= "xms_pl" # Provide preferered langage
            }
        )
        accesstoken = @(
            @{
                "name"= "ipaddr" # Provide ipaddress
            },
            @{
                "name"= "in_corp" # Provide if you connect from trusted location
            }
        )
    }
    api                    = @{
        oauth2PermissionScopes = @(
            @{
                "adminConsentDescription" = "Allow the app to read sign-in user files"
                "adminConsentDisplayName" = "Read users files"
                id                        = $((new-guid).guid) # has to be a unique value
                "isEnabled"               = 'true'
                "type"                    = "Admin" #Define the consent policy
                "userConsentDescription"  = "Allow the app to read your files"
                "userConsentDisplayName"  = "Read your files"
                "value"                   = "Files.Read"
            },
            @{
                "adminConsentDescription" = "Allow the app to read, create, modify, delete sign-in user files"
                "adminConsentDisplayName" = "Read and write users files"
                id                        = $((new-guid).guid) # has to be a unique value
                "isEnabled"               = 'true'
                "type"                    = "Admin" #Define the consent policy
                "userConsentDescription"  = "Allow the app to read, create, modify, delete your files"
                "userConsentDisplayName"  = "Write on your files"
                "value"                   = "Files.ReadWrite"
            }
        )
    }
}

    $settings | ConvertTo-Json -Depth 99 | Out-File -FilePath $(Join-Path -Path $OutputFolder -ChildPath "$DisplayName.json")
}