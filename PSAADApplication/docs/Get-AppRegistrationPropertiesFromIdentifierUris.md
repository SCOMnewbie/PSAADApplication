---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
schema: 2.0.0
---

# Get-AppRegistrationPropertiesFromIdentifierUris

## SYNOPSIS
This function will return your application information if the identifierUris has been defined.

## SYNTAX

```
Get-AppRegistrationPropertiesFromIdentifierUris [-AccessToken] <String> [-IdentifierUris] <String>
 [<CommonParameters>]
```

## DESCRIPTION
You can create multiple application with the same name, but only one with the same identifierUris.
This property can be set only when a service principal is enabled
for a specific App Registration.

## EXAMPLES

### EXAMPLE 1
```
Get-AppRegistrationPropertiesFromIdentifierUris -AccessToken "Bearrer ..." -IdentifierUris "api://<guid>"
```

"will return something only if your application has been declared."

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

### -IdentifierUris
Specify the IdentifierUris of the App registration

```yaml
Type: String
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
