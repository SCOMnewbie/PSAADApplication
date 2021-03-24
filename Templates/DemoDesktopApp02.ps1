
# Template to generate a simple Desktop app where the app can contact the Graph API to generate refresh tokens and you can read groups in delegated mode.
$settings = @{
    displayName = $DisplayName
    publicClient = @{                   #### This is for desktop app only! SPA, Web, Mobile will have another property
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
        }
    )
    groupMembershipClaims = "SecurityGroup" # Add information into groups property into the ClientId token. Value can be: none/all (both SG and DL)/SecurityGroup
    optionalClaims = @{
        idToken = @(
            @{
                name = "ipaddr" #Will add the client ip address in the IDToken (not available by default)
            }
        )
    }
}