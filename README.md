# Indented.IniFile

[![Build status](https://ci.appveyor.com/api/projects/status/0phufykxpv3q86e2?svg=true)](https://ci.appveyor.com/project/indented-automation/indented-inifile)

## Installation

Indented.IniFile can be installed from the PowerShell gallery.

```powershell
Install-Module Indented.IniFile
```

Indented.IniFile is compatible with PowerShell 5, 6 and 7.

## About

Indented.IniFile differs from existing PowerShell-based parsers in that it supports values with the same name. This support is required for files such as php.ini.

## Commands

Indented.IniFile includes four commands:

* Get-IniFileItem
* Get-IniFileSection
* Remove-IniFileItem
* Set-IniFileItem

## DSC resources

Indented.IniFile includes a DSC resource for managing INI file content.

### IniFileItem

* Ensure - Present or Absent. Present by default.
* Name - The name of the value to manage. A resource key.
* Section - The name of the section to manage.
* Value - The existing value to filter on.
* NewValue - The value to set.
* Path - The path to the ini file to configure. A resource key.
