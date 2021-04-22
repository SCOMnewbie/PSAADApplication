Function Get-AppRegistrationPropertiesFromIdentifierUris {
    <#
    .SYNOPSIS
    This function will return your application information if the identifierUris has been defined.

    .DESCRIPTION
    You can create multiple application with the same name, but only one with the same identifierUris. This property can be set only when a service principal is enabled
    for a specific App Registration.

    .PARAMETER AccessToken
    Specify token you use to run the query

    .PARAMETER IdentifierUris
    Specify the IdentifierUris of the App registration

    .EXAMPLE
    PS> Get-AppRegistrationPropertiesFromIdentifierUris -AccessToken "Bearrer ..." -IdentifierUris "api://<guid>"
    
    "will return something only if your application has been declared."

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
        [string]$IdentifierUris
    )

    $Headers = @{
        'Authorization' = $AccessToken
        "Content-Type"  = 'application/json'
    }

    $Params = @{
        ErrorAction       = "Stop"
        Headers           = $Headers
        uri               = "https://graph.microsoft.com/v1.0/applications?`$filter=identifierUris/any(c:c eq `'$IdentifierUris`')"
        Body              = $null
        method            = 'Get'
    }

    (Invoke-RestMethod @Params).value
}