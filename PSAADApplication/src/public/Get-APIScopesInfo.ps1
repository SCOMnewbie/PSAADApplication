Function Get-APIScopesInfo {
    <#
    .SYNOPSIS
    This function will return either delegated or applications available scopes  for the Graph API app.

    .DESCRIPTION
    This function will return either delegated or applications permission for specific scopes. By default it will use the Graph API app. You can filter on a specific keyword if you want to filter.
    You can extract from this cmdlet the required Id.

    .PARAMETER AccessToken
    Specify token you use to run the query

    .PARAMETER ScopeKeyword
    Specify a word to apply filter

    .PARAMETER Deleguated
    Specify you look for delegated permissions

    .PARAMETER Application
    Specify you look for application permissions

    .EXAMPLE
    PS> Get-APIScopesInfo -AccessToken "Bearrer ..." -ScopeKeyword "group" -Deleguated

    "Will return all available scopes with the word group in both value and description with delegated permission."

    .EXAMPLE
    PS> Get-APIScopesInfo -AccessToken "Bearrer ..." -ScopeKeyword "group" -Application
    
    "Will return all available scopes with the word group in both value and description with application permission."

    .EXAMPLE
    PS> Get-APIScopesInfo -AccessToken "Bearrer ..." -ScopeKeyword "group" -Application -AppId f6eb2883-3454-4520-860c-222f796bd929
    
    "Will return all available scopes from your app Id"

    .NOTES
    VERSION HISTORY
    1.0 | 2021/03/22 | Francois LEON
        initial version
    1.1 | 2021/03/29 | Francois LEON
        added both delegated and application available scopes
    POSSIBLE IMPROVEMENT
        -
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true, ParameterSetName = 'Deleguated')]
        [parameter(Mandatory = $true, ParameterSetName = 'Application')]
        [string]$AccessToken,
        [Parameter(ParameterSetName = 'Deleguated')]
        [Parameter(ParameterSetName = 'Application')]
        [string]$ScopeKeyword,
        [parameter(Mandatory = $true, ParameterSetName = 'Deleguated')]
        [switch]$Deleguated,
        [parameter(Mandatory = $true, ParameterSetName = 'Application')]
        [switch]$Application,
        [string]$AppId = '00000003-0000-0000-c000-000000000000' #By default graph API
    )

    $Headers = @{
        'Authorization' = $AccessToken
        "Content-Type"  = 'application/json'
    }

    $Params = @{
        ErrorAction = "Stop"
        Headers     = $Headers
        uri         = "https://graph.microsoft.com/v1.0/servicePrincipals?`$filter=appId eq '$AppId'"
        Body        = $null
        method      = 'Get'
    }

    foreach ($Key in $PSBoundParameters.Keys) {
        switch ($Key) {
            'Deleguated' { $results = (Invoke-RestMethod @Params).value.oauth2PermissionScopes; break }
            'Application' { $results = (Invoke-RestMethod @Params).value.appRoles; break }
        }
    }

    if ([string]::IsNullOrEmpty($ScopeKeyword)) {
        $results
    }
    else {
        $results | Where-Object { ($_.value -like "*$ScopeKeyword*") -or ($_.description -like "*$ScopeKeyword*") }
    }
}