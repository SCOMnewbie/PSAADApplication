<#
.SYNOPSIS
This function add a logo to an app registration.
.DESCRIPTION
This function add a logo to an app registration.
.PARAMETER AccessToken
Specify token you use to run the query
.PARAMETER ObjectId
Specify the GUID of the App registration
.PARAMETER LogoPath
Specify the path of the logo you want to upload

.EXAMPLE
Add-AppRegistrationLogo -AccessToken "Bearrer ..." -ObjectId <Guid> -LogoPath '.\logo.png'

Will upload a logo to the App registration
.LINK
https://docs.microsoft.com/en-us/graph/api/resources/application?view=graph-rest-1.0
.NOTES
VERSION HISTORY
1.0 | 2021/03/22 | Francois LEON
    initial version
POSSIBLE IMPROVEMENT
    -
#>
Function Add-AppRegistrationLogo {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [string]$AccessToken,
        [parameter(Mandatory = $true)]
        [guid]$ObjectId, # Of the App registration
        [parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ })]
        [string]$LogoPath
    )

    $Headers = @{
        'Authorization' = $AccessToken
        "Content-Type"  = 'image/png'
    }
    
    $Params = @{
        ErrorAction = "Stop"
        Headers     = $Headers
        uri         = "https://graph.microsoft.com/v1.0/applications/$ObjectId/logo"
        Body        = $null
        Infile      = $LogoPath
        method      = 'Put'
    }

    Invoke-RestMethod @Params
}