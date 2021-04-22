---
external help file: PSAADApplication-help.xml
Module Name: PSAADApplication
online version: https://docs.microsoft.com/en-us/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http
schema: 2.0.0
---

# Convert-SettingsToJson

## SYNOPSIS
This function will compile and convert your app settings in a json file.

## SYNTAX

```
Convert-SettingsToJson [[-OutputFolder] <String>] [-TemplateSettings] <Hashtable> [<CommonParameters>]
```

## DESCRIPTION
This function will compile and convert your app settings in a json file.
The goal here is mainly to generate displayname and GUID on the fly.

## EXAMPLES

### EXAMPLE 1
```
$BackendSettings = @{<app settings>}
$BackendSettingInJson = Convert-SettingsToJson -TemplateSettings $BackendSettings
```

"Will transform the hashtable into a json object"

## PARAMETERS

### -OutputFolder
Specify where the json will be generated if specified

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateSettings
Specify the template to convert in Json

```yaml
Type: Hashtable
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
1.1 | 2021/04/13 | Francois LEON
    - Change the function to avoid having to copy/paste template in the function.
    Instead we just provide the template (Hashtable) directly into a variable
    - Now the function can either return raw json into the console or out-file into a folder
POSSIBLE IMPROVEMENT
    -

## RELATED LINKS
