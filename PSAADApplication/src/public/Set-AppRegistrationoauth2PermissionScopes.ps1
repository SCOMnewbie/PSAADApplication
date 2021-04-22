Function Set-AppRegistrationoauth2PermissionScopes {
    <#
    .SYNOPSIS
    This function will populate the scopes you plan to expose with your application.

    .DESCRIPTION
    This function will populate the scopes you plan to expose with your application. We can find them under the Expose an API menu in the app registration.
    This function is using the same template used in the New-AppRegistration command, but this time will focus only on the oauth2PermissionScopes properties.

    .PARAMETER AccessToken
    Specify token you use to run the query

    .PARAMETER InputWithFile
    Specify a json template with the confiiguration of your app registration through a file

    .PARAMETER InputWithVariable
    Specify a json template with the confiiguration of your app registration through a variable

    .PARAMETER ObjectId
    Specify the GUID of the App registration

    .EXAMPLE
    PS> Set-AppRegistrationoauth2PermissionScopes -AccessToken "Bearrer ..." -ConfigFilePath -ConfigFilePath ".\Output\MyWebApp01.json" -ObjectId

    "Will expose scopes to a specific custom API."

    .NOTES
    VERSION HISTORY
    1.0 | 2021/03/22 | Francois LEON
        initial version
    POSSIBLE IMPROVEMENT
        -
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [string]$AccessToken,
        [parameter(Mandatory = $true, ParameterSetName = "InputWithFile")]
        [ValidateScript( {
                if (Get-Content $_ -Raw | ConvertFrom-Json -ErrorAction Stop) {
                    $true
                }
                else {
                    throw "$_ is  and invalid json file"
                }
            })]
        $InputWithFile,
        [parameter(Mandatory = $true, ParameterSetName = "InputWithVariable")]
        [ValidateScript( {
                if ( $_ | ConvertFrom-Json -ErrorAction Stop) {
                    $true
                }
                else {
                    throw "$_ is  and invalid json file"
                }
            })]
        $InputWithVariable,
        $ObjectId # From app registration
    )

    if ($InputWithFile) {
        #Load template
        $ConfigData = Get-Content $InputWithFile -raw | ConvertFrom-Json -Depth 20
    }
    else {
        #Means input with variable
        $ConfigData = $InputWithVariable | ConvertFrom-Json -Depth 20
    }

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

    #Oauth2Permission has to be an array!
    $BodyPayload = @{
        api = $($ConfigData.api)
    }

    $Params.Body = $BodyPayload | ConvertTo-Json -Depth 99
    Invoke-RestMethod @Params
}