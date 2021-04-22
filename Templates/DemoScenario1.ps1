$settings = @{
    displayName = $DisplayName
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
                    id = "6be147d2-ea4f-4b5a-a3fa-3eab6f3c140a" # mail.readbasic  Thx Get-GraphAPIScopesInfo -AccessToken $token -ScopeKeyword "mail" -application
                    type = "Role"                               # Role means application, and scope delegated
                }
            )
        }
    )
}