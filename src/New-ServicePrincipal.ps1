<#
.SYNOPSIS
This function will create a service principal and link it to your app registration.
.DESCRIPTION
This function will create a service principal and link it to your app registration.
.PARAMETER AccessToken
Specify token you use to run the query
.PARAMETER AppId
Specify the GUID of the App registration
.EXAMPLE
New-ServicePrincipal -AccessToken "Bearrer ..." -AppId <GUID>

Will create a SP and link t to your previously created app registration.
.NOTES
VERSION HISTORY
1.0 | 2021/03/22 | Francois LEON
    initial version
POSSIBLE IMPROVEMENT
    -
#>
Function New-ServicePrincipal {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [string]$AccessToken,
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
        uri               = "https://graph.microsoft.com/v1.0/servicePrincipals"
        Body              = $null
        method            = 'Post'
    }

    $BodyPayload = @{
        appId = $AppId
    }
    
    $Params.Body = $BodyPayload | ConvertTo-Json
    Invoke-RestMethod @Params
}