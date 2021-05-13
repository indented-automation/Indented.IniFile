---
external help file: Indented.IniFile-help.xml
Module Name: Indented.IniFile
online version:
schema: 2.0.0
---

# Get-IniFileItem

## SYNOPSIS
Get an item from an Ini file.

## SYNTAX

### DefaultSearch (Default)
```
Get-IniFileItem [[-Name] <String>] [[-Section] <String>] -Path <String> [<CommonParameters>]
```

### SearchUsingValue
```
Get-IniFileItem [[-Name] <String>] [[-Section] <String>] -Path <String> -Value <String> [<CommonParameters>]
```

### SearchUsingLiteralValue
```
Get-IniFileItem [[-Name] <String>] [[-Section] <String>] -Path <String> -LiteralValue <String>
 [<CommonParameters>]
```

## DESCRIPTION
Reads an Ini file, returning matching items.

The ini file items returned by this function include an Extent property which describes the location of an item within the file.

## EXAMPLES

### EXAMPLE 1
```
Get-IniFileItem -Path somefile.ini
```

Get all items in somefile.ini.

### EXAMPLE 2
```
Get-IniFileItem -Section somesection -Path somefile.ini
```

Get all items within the second "somesection" from somefile.ini.

### EXAMPLE 3
```
Get-IniFileItem -Name somename -Path somefile.ini
```

Get all items named somename from any section.

## PARAMETERS

### -Name
The name of the field to retrieve.
The Name parameter supports wildcards.
By default, all fields are returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -Section
The section a setting resides within.
The Section parameter supports wildcrds.
By default, all sections are returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: *
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
Accept pipeline input: True (ByPropertyName, ByValue)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### IniFileItem
## NOTES

## RELATED LINKS
