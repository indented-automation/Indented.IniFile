---
external help file: Indented.IniFile-help.xml
Module Name: Indented.IniFile
online version:
schema: 2.0.0
---

# Remove-IniFileItem

## SYNOPSIS
Get an item from an Ini file.

## SYNTAX

### DefaultSearch (Default)
```
Remove-IniFileItem [-Name] <String> [[-Section] <String>] [-Path] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### FromPipeline
```
Remove-IniFileItem -InputObject <PSObject> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SearchUsingLiteralValue
```
Remove-IniFileItem [-Name] <String> [[-Section] <String>] [-Path] <String> -LiteralValue <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### SearchUsingValue
```
Remove-IniFileItem [-Name] <String> [[-Section] <String>] [-Path] <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Reads an Ini file, returning matching items.

## EXAMPLES

### EXAMPLE 1
```
Remove-IniFileItem -Name somename -Section somesection -Path somefile.ini
```

Remove somename from the somesection section in somefile.ini.

### EXAMPLE 2
```
Remove-IniFileItem -Name somename -Path somefile.ini
```

Remove somename from all sections in somefile.ini.

## PARAMETERS

### -InputObject
{{Fill InputObject Description}}

```yaml
Type: PSObject
Parameter Sets: FromPipeline
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
The name of the field to retrieve.

```yaml
Type: String
Parameter Sets: DefaultSearch, SearchUsingLiteralValue, SearchUsingValue
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Section
The section a setting resides within.
If this value is not set the value will be removed from all sections.

```yaml
Type: String
Parameter Sets: DefaultSearch, SearchUsingLiteralValue, SearchUsingValue
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The path to an ini file.

```yaml
Type: String
Parameter Sets: DefaultSearch, SearchUsingLiteralValue, SearchUsingValue
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The value may be defined to describe the item.
Wildcards are supported.

```yaml
Type: String
Parameter Sets: SearchUsingValue
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralValue
The literal value may be defined to absolutely describe the item.
Wildcards are not supported.

```yaml
Type: String
Parameter Sets: SearchUsingLiteralValue
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Void
## NOTES
Change log:
    30/01/2017 - Chris Dent - Created.

## RELATED LINKS
