<#
.SYNOPSIS
This function will populate the scopes you plan to expose with your application.
.DESCRIPTION
This function will populate the scopes you plan to expose with your application. We can find them under the Expose an API menu in the app registration.
This function is using the same template used in the New-AppRegistration command, but this time will focus only on the oauth2PermissionScopes properties.
.PARAMETER AccessToken
Specify token you use to run the query
.PARAMETER ConfigFilePath
Specify a json template with the confiiguration of your app registration
.PARAMETER ObjectId
Specify the GUID of the App registration
.EXAMPLE
Set-AppRegistrationoauth2PermissionScopes -AccessToken "Bearrer ..." -ConfigFilePath -ConfigFilePath ".\Output\MyWebApp01.json" -ObjectId

Will expose scopes to a specific custom API.
.NOTES
VERSION HISTORY
1.0 | 2021/03/22 | Francois LEON
    initial version
POSSIBLE IMPROVEMENT
    -
#>
Function Set-AppRegistrationoauth2PermissionScopes {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [string]$AccessToken,
        [parameter(Mandatory = $true)]
        [ValidateScript( {
                if (Get-Content $_ -Raw | ConvertFrom-Json -ErrorAction Stop) {
                    $true
                }
                else {
                    throw "$_ is  and invalid json file"
                }
            })]
        $ConfigFilePath,
        $ObjectId # From app registration
    )

    #Load data
    $ConfigData = Get-Content $ConfigFilePath -raw| ConvertFrom-Json -Depth 99

    $Headers = @{
        'Authorization' = $AccessToken
        "Content-Type"  = 'application/json'
    }
    
    $Params = @{
        ErrorAction       = "Stop"
        Headers           = $Headers
        uri               = "https://graph.microsoft.com/v1.0/applications/$ObjectId"
        Body              = $null
        method            = 'Patch'
    }

    <#
         "oauth2Permissions": [
       {
          "adminConsentDescription": "Allow the app to access resources on behalf of the signed-in user.",
          "adminConsentDisplayName": "Access resource1",
          "id": "<guid>",
          "isEnabled": true,
          "type": "User",
          "userConsentDescription": "Allow the app to access resource1 on your behalf.",
          "userConsentDisplayName": "Access resources",
          "value": "user_impersonation"
        }
    ]   ,
    #>

    #Oauth2Permission has to be an array!
    $BodyPayload = @{
        api = $($ConfigData.api)
    }
    
    $Params.Body = $BodyPayload | ConvertTo-Json -Depth 99
    Invoke-RestMethod @Params
}

#Set-AppRegistrationoauth2PermissionScopes -ObjectId "fsdf" -AccessToken "sdfsdf" -ConfigFilePath "C:\Git\Private\PSAADApplication\Output\DemoWebApp04.json"