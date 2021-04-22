---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
schema: 2.0.0
---

# Get-AppRegistrationProperties

## SYNOPSIS
This function will return your application properties from it's objectId.

## SYNTAX

```
Get-AppRegistrationProperties [-AccessToken] <String> [-ObjectId] <Guid> [<CommonParameters>]
```

## DESCRIPTION
You can create multiple application with the same name, but only one with the same identifierUris.
This property can be set only when a service principal is enabled
for a specific App Registration.

## EXAMPLES

### EXAMPLE 1
```
Get-AppRegistrationProperties -AccessToken "Bearrer ..." -ObjectId "<guid>"
```

"will return your application properties"

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
