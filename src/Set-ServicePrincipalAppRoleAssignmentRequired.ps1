<#
.SYNOPSIS
This function will permit you to configure your Service Princiapl to force the AppRoleAssignment.
.DESCRIPTION
When you create a ervice principal, by default, everyone from your tenant can access you application. This parameter force people to be assigned to get their access toekns.
.PARAMETER AccessToken
Specify token you use to run the query
.PARAMETER Required
Specify if yes or no assignment must be assign. By default it's true.
.PARAMETER ObjectId
Specify the GUID of the App registration
.EXAMPLE
Set-ServicePrincipalAppRoleAssignmentRequired -AccessToken "Bearrer ..."  -ObjectId <GUID>

Will configure your SP to make sure people has to be assign to get an AT
.NOTES
VERSION HISTORY
1.0 | 2021/03/22 | Francois LEON
    initial version
POSSIBLE IMPROVEMENT
    -
#>
Function Set-ServicePrincipalAppRoleAssignmentRequired {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [string]$AccessToken,
        [parameter(Mandatory = $true)]
        [guid]$ObjectId, #Of the Enterprise App (Service Principal)
        [bool]$Required = $true
    )

    $Headers = @{
        'Authorization' = $AccessToken
        "Content-Type"  = 'application/json'
    }
    
    $Params = @{
        ErrorAction       = "Stop"
        Headers           = $Headers
        uri               = "https://graph.microsoft.com/v1.0/servicePrincipals/$ObjectId"
        Body              = $null
        method            = 'Patch'
    }

    #The body is waiting string values
    if($Required){
        $RequiredString = "true"
    }
    else{
        $RequiredString = "false"
    }
    $BodyPayload = @{
        appRoleAssignmentRequired = $RequiredString
    }
    
    $Params.Body = $BodyPayload | ConvertTo-Json
    Invoke-RestMethod @Params
}