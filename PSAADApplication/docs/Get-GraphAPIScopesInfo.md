---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
schema: 2.0.0
---

# Get-GraphAPIScopesInfo

## SYNOPSIS
This function will return either delegated or applications available scopes  for the Graph API app.

## SYNTAX

### Application
```
Get-GraphAPIScopesInfo -AccessToken <String> [-ScopeKeyword <String>] [-Application] [-AppId <String>]
 [<CommonParameters>]
```

### Deleguated
```
Get-GraphAPIScopesInfo -AccessToken <String> [-ScopeKeyword <String>] [-Deleguated] [-AppId <String>]
 [<CommonParameters>]
```

## DESCRIPTION
This function will return either delegated or applications permission for specific scopes.
By default it will use the Graph API app.
You can filter on a specific keyword if you want to filter.
You can extract from this cmdlet the required Id.

## EXAMPLES

### EXAMPLE 1
```
Get-GraphAPIScopesInfo -AccessToken "Bearrer ..." -ScopeKeyword "group" -Deleguated
```

"Will return all available scopes with the word group in both value and description with delegated permission."

### EXAMPLE 2
```
Get-GraphAPIScopesInfo -AccessToken "Bearrer ..." -ScopeKeyword "group" -Application
```

"Will return all available scopes with the word group in both value and description with application permission."

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

### -ScopeKeyword
Specify a word to apply filter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Deleguated
Specify you look for delegated permissions

```yaml
Type: SwitchParameter
Parameter Sets: Deleguated
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Application
Specify you look for application permissions

```yaml
Type: SwitchParameter
Parameter Sets: Application
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppId
By default graph API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 00000003-0000-0000-c000-000000000000
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
1.1 | 2021/03/29 | Francois LEON
    added both delegated and application available scopes
POSSIBLE IMPROVEMENT
    -

## RELATED LINKS
