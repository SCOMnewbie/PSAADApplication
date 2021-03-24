<#
.SYNOPSIS
This function will return your application properties from it's objectId.
.DESCRIPTION
You can create multiple application with the same name, but only one with the same identifierUris. This property can be set only when a service principal is enabled
for a specific App Registration.
.PARAMETER AccessToken
Specify token you use to run the query
.PARAMETER ObjectId
Specify the GUID of the App registration
.EXAMPLE
Get-AppRegistrationProperties -AccessToken "Bearrer ..." -ObjectId "<guid>"

will return your application properties
.NOTES
VERSION HISTORY
1.0 | 2021/03/22 | Francois LEON
    initial version
POSSIBLE IMPROVEMENT
    -
#>
Function Get-AppRegistrationProperties {
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
        ErrorAction       = "Stop"
        Headers           = $Headers
        uri               = "https://graph.microsoft.com/v1.0/applications/$ObjectId" #ObjectId
        Body              = $null
        method            = 'Get'
    }
    
    Invoke-RestMethod @Params
}