---
external help file: Indented.IniFile-help.xml
Module Name: Indented.IniFile
online version:
schema: 2.0.0
---

# Set-IniFileItem

## SYNOPSIS
Set the value of an item in an INI file.

## SYNTAX

### DefaultSearch (Default)
```
Set-IniFileItem [-Name] <String> [-Section <String>] [-NewValue] <String> -Path <String>
 [-ExpandEnvironmentVariables] [-IncludePadding] [-Encoding <Encoding>] [-EndOfLine <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### SearchUsingValue
```
Set-IniFileItem [-Name] <String> [-Section <String>] -Value <String> [-NewValue] <String> -Path <String>
 [-ExpandEnvironmentVariables] [-IncludePadding] [-Encoding <Encoding>] [-EndOfLine <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### SearchUsingLiteralValue
```
Set-IniFileItem [-Name] <String> [-Section <String>] -LiteralValue <String> [-NewValue] <String> -Path <String>
 [-ExpandEnvironmentVariables] [-IncludePadding] [-Encoding <Encoding>] [-EndOfLine <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the value of an item in an INI file.

Set-IniFileItem allows

## EXAMPLES

### EXAMPLE 1
```
Set-IniFileItem -Name itemName -NewValue someValue -Path config.ini
```

Set a value for itemName in config.ini.

### EXAMPLE 2
```
Set-IniFileItem -Name itemName -Value currentValue -NewValue newValue -Path config.ini
```

Set a new value for itemName with value currentValue.

### EXAMPLE 3
```
Set-IniFileItem -Name extension -Value ldap -NewValue ldap -Path php.ini
```

Set a value for extension to LDAP.
Other extension items in the file are ignored because of the Value filter.

## PARAMETERS

### -Name
The name of an item to add or edit.

If the item does not exist it will be created.
Section is mandatory for new items.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Section
The name of a section to add the item to.
If the section does not exist it will be created.

Section must be defined when adding a new value.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### -NewValue
The value of the item.

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

### -Path
The path to an ini file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: FullName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExpandEnvironmentVariables
Request expansion of environment variables within the value.

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

### -IncludePadding
Add spaces around the = symbol.
For example, sets "Name = Value" instead of "Name=Value".

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

### -Encoding
If the INI file already exists the files current encoding will be used.
If not, an encoding may be specified using this parameter.
By default, files are saved using UTF8 encoding with no BOM.

```yaml
Type: Encoding
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: [System.Text.UTF8Encoding]::new($false)
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndOfLine
The default end of line character used when creating new files.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: [Environment]::NewLine
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
