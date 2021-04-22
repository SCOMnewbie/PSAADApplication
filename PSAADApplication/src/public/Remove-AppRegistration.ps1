Function Remove-AppRegistration {
    <#
    .SYNOPSIS
    This function will delete your app registration.

    .DESCRIPTION
    This function will delete your app registration. Will also delete SP if there is one.

    .PARAMETER AccessToken
    Specify token you use to run the query

    .PARAMETER ObjectId
    Specify the GUID of the App registration

    .EXAMPLE
    PS> Remove-AppRegistration -AccessToken "Bearrer ..." -ObjectId <GUID>
    
    "Will delete the app registration and SP associated if there is one."

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
        [guid]$ObjectId # Of the App registration
    )

    $Headers = @{
        'Authorization' = $AccessToken
        "Content-Type"  = 'application/json'
    }

    $Params = @{
        ErrorAction = "Stop"
        Headers     = $Headers
        uri         = "https://graph.microsoft.com/v1.0/applications/$ObjectId" #ObjectId
        Body        = $null
        method      = 'Delete'
    }

    Invoke-RestMethod @Params
}