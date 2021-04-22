---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/resources/application?view=graph-rest-1.0
schema: 2.0.0
---

# Add-AppRegistrationLogo

## SYNOPSIS
This function add a logo to an app registration.

## SYNTAX

```
Add-AppRegistrationLogo [-AccessToken] <String> [-ObjectId] <Guid> [-LogoPath] <String> [<CommonParameters>]
```

## DESCRIPTION
This function add a logo to an app registration.

## EXAMPLES

### EXAMPLE 1
```
Add-AppRegistrationLogo -AccessToken "Bearrer ..." -ObjectId <Guid> -LogoPath '.\logo.png'
```

"Will upload a logo to the App registration"

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

### -LogoPath
Specify the path of the logo you want to upload

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

[https://docs.microsoft.com/en-us/graph/api/resources/application?view=graph-rest-1.0](https://docs.microsoft.com/en-us/graph/api/resources/application?view=graph-rest-1.0)

