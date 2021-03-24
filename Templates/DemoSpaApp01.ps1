
# Template to generate a simple Desktop app where the app can contact the Graph API to generate refresh tokens and you can read groups in delegated mode.
$settings = @{
    displayName = $DisplayName
    spa = @{
        redirectUris= @(
            "https://MyAwesomApp01Spa:5050",  # Array here can have multiple values
            "https://MyAwesomApp01Spa:5051"   # why not, it's an array!
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
        }
    )
    appRoles               = @(
        @{
            allowedMemberTypes = @("User")                   # Can be user and/or application
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
    web                    = @{                   # For Auth_code (+ PKCE)
        implicitGrantSettings = @{
            enableIdTokenIssuance     = "false"
            enableAccessTokenIssuance = "false"
        }
    }
}