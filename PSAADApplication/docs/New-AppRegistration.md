---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
schema: 2.0.0
---

# New-AppRegistration

## SYNOPSIS
This function will create an app registration based on a provided template file.

## SYNTAX

### InputWithFile
```
New-AppRegistration -AccessToken <String> -InputWithFile <Object> [-ConfidentialApp] [<CommonParameters>]
```

### InputWithVariable
```
New-AppRegistration -AccessToken <String> -InputWithVariable <Object> [-ConfidentialApp] [<CommonParameters>]
```

## DESCRIPTION
This function will create an app registration based on a provided template file.
Because there is so much possibilities, we have to use a template file or variable to build our app.
To avoid mistakes, this function define "hardcode" few parameters like the apiToken Version, and the singletenant parameter.
This part won't necessary fit your need.

## EXAMPLES

### EXAMPLE 1
```
New-AppRegistration -AccessToken "Bearrer ..." -ConfigFilePath -ConfigFilePath ".\Output\MyWebApp01.json" -ConfidentialApp
```

"Will create a confidential, single tenant application based on the provided template."

## PARAMETERS

### -AccessToken
Specify token you use to run the query

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputWithFile
Specify a json template with the confiiguration of your app registration through a file

```yaml
Type: Object
Parameter Sets: InputWithFile
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputWithVariable
Specify a json template with the confiiguration of your app registration through a variable

```yaml
Type: Object
Parameter Sets: InputWithVariable
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfidentialApp
Specify if you want to create a confidential app (RBAC + Web App) instead of the default public one.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
