Function Add-AppRegistrationPassword {
    <#
    .SYNOPSIS
    This function generate a password to an confidential app registration.

    .DESCRIPTION
    This function generate a password to an confidential app registration.

    .PARAMETER AccessToken
    Specify token you use to run the query

    .PARAMETER ObjectId
    Specify the GUID of the App registration

    .EXAMPLE
    PS>Add-AppRegistrationPassword -AccessToken "Bearrer ..." -ObjectId <Guid>

    "Will generate a 2 years secrets and return it in the output."
    
    .LINK
    https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http

    .NOTES
    VERSION HISTORY
    1.0 | 2021/03/22 | Francois LEON
        initial version
    POSSIBLE IMPROVEMENT
        - Manage other datetime. The code it already commented.
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
        uri         = "https://graph.microsoft.com/v1.0/applications/$ObjectId/addPassword"
        Body        = $null
        method      = 'Post'
    }

    <#
    # If you want to do never expire
    $passwordCredential = @{
        displayName =  "Password friendly name3" #By default 2 years
        endDateTime = '2042-01-01T00:00:00Z' #like a never
    }

    $BodyPayload = @{
        passwordCredential = $passwordCredential
    }

    $Params.Body = $BodyPayload | ConvertTo-Json -Depth 20
    #>

    Invoke-RestMethod @Params
}