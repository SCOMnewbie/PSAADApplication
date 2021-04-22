---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
schema: 2.0.0
---

# Set-ServicePrincipalAppRoleAssignmentRequired

## SYNOPSIS
This function will permit you to configure your Service Princiapl to force the AppRoleAssignment.

## SYNTAX

```
Set-ServicePrincipalAppRoleAssignmentRequired [-AccessToken] <String> [-ObjectId] <Guid>
 [[-Required] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
When you create a ervice principal, by default, everyone from your tenant can access you application.
This parameter force people to be assigned to get their access toekns.

## EXAMPLES

### EXAMPLE 1
```
Set-ServicePrincipalAppRoleAssignmentRequired -AccessToken "Bearrer ..."  -ObjectId <GUID>
```

"Will configure your SP to make sure people has to be assign to get an AT"

## PARAMETERS

### -AccessToken
Specify token you use to run the query

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specify the GUID of the App registration

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Required
Specify if yes or no assignment must be assign.
By default it's true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
VERSION HISTORY
1.0 | 2021/03/22 | Francois LEON
    initial version
POSSIBLE IMPROVEMENT
    -

## RELATED LINKS
