<#
.SYNOPSIS
This function will return all the available scopes Graph API offers.
.DESCRIPTION
This function will return all the available scopes Graph API offers. You can filter on a specific keyword if you want to filter. This function is useful when you 
have to create your application settings. You can from this function extract the specific Id you will need into the requiredResourceAccess properties.

.PARAMETER AccessToken
Specify token you use to run the query
.PARAMETER ScopeKeyword
Specify a word to apply filter

.EXAMPLE
Get-GraphAPIScopesInfo -AccessToken "Bearrer ..." -ScopeKeyword "group"

Will return all available scopes
.NOTES
VERSION HISTORY
1.0 | 2021/03/22 | Francois LEON
    initial version
POSSIBLE IMPROVEMENT
    -
#>
Function Get-GraphAPIScopesInfo {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [string]$AccessToken,
        [string]$ScopeKeyword
    )

    $Headers = @{
        'Authorization' = $AccessToken
        "Content-Type"  = 'application/json'
    }
    
    $Params = @{
        ErrorAction       = "Stop"
        Headers           = $Headers
        uri               = "https://graph.microsoft.com/v1.0/servicePrincipals?`$filter=appId eq '00000003-0000-0000-c000-000000000000'" # well known Graph API Id
        Body              = $null
        method            = 'Get'
    }

    $results = (Invoke-RestMethod @Params).value.oauth2PermissionScopes

    if([string]::IsNullOrEmpty($ScopeKeyword)){
        $results
    }
    else {
        $results | Where-Object{($_.value -like "*$ScopeKeyword*") -or ($_.value -like "*$ScopeKeyword*")}
    }
}