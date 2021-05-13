---
external help file: Indented.IniFile-help.xml
Module Name: Indented.IniFile
online version:
schema: 2.0.0
---

# Get-IniFileSection

## SYNOPSIS
Get a section from an Ini file.

## SYNTAX

```
Get-IniFileSection [[-Name] <String>] [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION
Reads an Ini file, returning matching sections.

The ini file sections returned by this function includes an Extent property which describes the location of a section within the file.

## EXAMPLES

### EXAMPLE 1
```
Get-IniFileItem -Path somefile.ini
```

Get all sections in somefile.ini.

### EXAMPLE 2
```
Get-IniFileSection -Name somesection -Path somefile.ini
```

Get the section named "somesection" from somefile.ini.

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
Position: 1
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
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### IniFileSection
## NOTES

## RELATED LINKS
