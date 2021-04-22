---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
schema: 2.0.0
---

# New-ServicePrincipal

## SYNOPSIS
This function will create a service principal and link it to your app registration.

## SYNTAX

```
New-ServicePrincipal [-AccessToken] <String> [-AppId] <Guid> [<CommonParameters>]
```

## DESCRIPTION
This function will create a service principal and link it to your app registration.

## EXAMPLES

### EXAMPLE 1
```
New-ServicePrincipal -AccessToken "Bearrer ..." -AppId <GUID>
```

"Will create a SP and link t to your previously created app registration."

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

### -AppId
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
