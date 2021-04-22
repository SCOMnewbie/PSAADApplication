---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
schema: 2.0.0
---

# Remove-AppRegistration

## SYNOPSIS
This function will delete your app registration.

## SYNTAX

```
Remove-AppRegistration [-AccessToken] <String> [-ObjectId] <Guid> [<CommonParameters>]
```

## DESCRIPTION
This function will delete your app registration.
Will also delete SP if there is one.

## EXAMPLES

### EXAMPLE 1
```
Remove-AppRegistration -AccessToken "Bearrer ..." -ObjectId <GUID>
```

"Will delete the app registration and SP associated if there is one."

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
