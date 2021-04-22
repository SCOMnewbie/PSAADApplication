---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
schema: 2.0.0
---

# Set-AppRegistrationoauth2PermissionScopes

## SYNOPSIS
This function will populate the scopes you plan to expose with your application.

## SYNTAX

### InputWithFile
```
Set-AppRegistrationoauth2PermissionScopes -AccessToken <String> -InputWithFile <Object> [-ObjectId <Object>]
 [<CommonParameters>]
```

### InputWithVariable
```
Set-AppRegistrationoauth2PermissionScopes -AccessToken <String> -InputWithVariable <Object>
 [-ObjectId <Object>] [<CommonParameters>]
```

## DESCRIPTION
This function will populate the scopes you plan to expose with your application.
We can find them under the Expose an API menu in the app registration.
This function is using the same template used in the New-AppRegistration command, but this time will focus only on the oauth2PermissionScopes properties.

## EXAMPLES

### EXAMPLE 1
```
Set-AppRegistrationoauth2PermissionScopes -AccessToken "Bearrer ..." -ConfigFilePath -ConfigFilePath ".\Output\MyWebApp01.json" -ObjectId
```

"Will expose scopes to a specific custom API."

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

### -ObjectId
Specify the GUID of the App registration

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
