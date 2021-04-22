Function Convert-SettingsToJson {
    <#
    .SYNOPSIS
    This function will compile and convert your app settings in a json file.

    .DESCRIPTION
    This function will compile and convert your app settings in a json file. The goal here is mainly to generate displayname and GUID on the fly.

    .PARAMETER TemplateSettings
    Specify the template to convert in Json

    .PARAMETER OutputFolder
    Specify where the json will be generated if specified

    .EXAMPLE
    PS> $BackendSettings = @{<app settings>}
    $BackendSettingInJson = Convert-SettingsToJson -TemplateSettings $BackendSettings
    
    "Will transform the hashtable into a json object"

    .NOTES
    VERSION HISTORY
    1.0 | 2021/03/22 | Francois LEON
        initial version
    1.1 | 2021/04/13 | Francois LEON
        - Change the function to avoid having to copy/paste template in the function.
        Instead we just provide the template (Hashtable) directly into a variable
        - Now the function can either return raw json into the console or out-file into a folder
    POSSIBLE IMPROVEMENT
        -
    #>
    [cmdletbinding()]
    param(
        [ValidateScript( { Test-Path $_ })]
        [string]$OutputFolder,
        [parameter(Mandatory = $true)]
        [ValidateScript( { -not [string]::IsNullOrEmpty($_.DisplayName) })]
        [System.Collections.Hashtable]$TemplateSettings #Displayname can't be null or empty in the settings. This is the only mandatory parameter
    )

    if ($OutputFolder) {
        $TemplateSettings | ConvertTo-Json -Depth 99 | Out-File -FilePath $(Join-Path -Path $OutputFolder -ChildPath "$($TemplateSettings.DisplayName).json")
    }
    else {
        $TemplateSettings | ConvertTo-Json -Depth 99
    }
}