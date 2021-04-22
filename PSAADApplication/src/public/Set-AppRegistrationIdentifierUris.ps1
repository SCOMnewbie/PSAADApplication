Function Set-AppRegistrationidentifierUris {
    <#
    .SYNOPSIS
    This function will specify a identifierUris to an app registration.

    .DESCRIPTION
    This function will specify a identifierUris to an app registration. The function hardcode the result with a api://<guid> which is how azure create it by default.
    Service Principal is required to enable this attribute.

    .PARAMETER AccessToken
    Specify token you use to run the query

    .PARAMETER ObjectId
    Specify the GUID of the App registration

    .PARAMETER AppId
    Specify the GUID of the App registration

    .EXAMPLE
    PS> Set-AppRegistrationidentifierUris -AccessToken "Bearrer ..." -AppId <GUID> -ObjectId <GUID>

    "Will add a identifierUris to your app registration."

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
        [parameter(Mandatory = $true)]
        [guid]$ObjectId, #Of the App registration
        [parameter(Mandatory = $true)]
        [guid]$AppId #Of the App registration
    )

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

    $BodyPayload = @{
        identifierUris = @("api://$AppId")
    }

    $Params.Body = $BodyPayload | ConvertTo-Json
    Invoke-RestMethod @Params
}