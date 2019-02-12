---
external help file: Indented.IniFile-help.xml
Module Name: Indented.IniFile
online version:
schema: 2.0.0
---

# Set-IniFileItem

## SYNOPSIS
{{Fill in the Synopsis}}

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
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

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

### -Encoding
{{Fill Encoding Description}}

```yaml
Type: Encoding
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndOfLine
{{Fill EndOfLine Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: 
, 


Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpandEnvironmentVariables
{{Fill ExpandEnvironmentVariables Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludePadding
{{Fill IncludePadding Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralValue
{{Fill LiteralValue Description}}

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

### -Name
{{Fill Name Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NewValue
{{Fill NewValue Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
{{Fill Path Description}}

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

### -Section
{{Fill Section Description}}

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
{{Fill Value Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
