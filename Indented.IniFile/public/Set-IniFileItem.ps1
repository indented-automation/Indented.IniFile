using namespace System.Text

function Set-IniFileItem {
    <#
    .SYNOPSIS
        Set the value of an item in an INI file.

    .DESCRIPTION
        Set the value of an item in an INI file.

        Set-IniFileItem allows

    .EXAMPLE
        Set-IniFileItem -Name itemName -NewValue someValue -Path config.ini

        Set a value for itemName in config.ini.

    .EXAMPLE
        Set-IniFileItem -Name itemName -Value currentValue -NewValue newValue -Path config.ini

        Set a new value for itemName with value currentValue.

    .EXAMPLE
        Set-IniFileItem -Name extension -Value ldap -NewValue ldap -Path php.ini

        Set a value for extension to LDAP. Other extension items in the file are ignored because of the Value filter.
    #>

    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'DefaultSearch')]
    param (
        # The name of an item to add or edit.
        #
        # If the item does not exist it will be created. Section is mandatory for new items.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [String]$Name,

        # The name of a section to add the item to. If the section does not exist it will be created.
        #
        # Section must be defined when adding a new value.
        [Parameter(ValueFromPipelineByPropertyName)]
        [String]$Section,

        # The value may be defined to describe the item. Wildcards are supported.
        [Parameter(Mandatory, ParameterSetName = 'SearchUsingValue')]
        [String]$Value,

        # The literal value may be defined to absolutely describe the item. Wildcards are not supported.
        [Parameter(Mandatory, ParameterSetName = 'SearchUsingLiteralValue')]
        [String]$LiteralValue,

        # The value of the item.
        [Parameter(Mandatory, Position = 2)]
        [AllowEmptyString()]
        [String]$NewValue,

        # The path to an ini file.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FullName')]
        [String]$Path,

        # Request expansion of environment variables within the value.
        [Switch]$ExpandEnvironmentVariables,

        # Add spaces around the = symbol. For example, sets "Name = Value" instead of "Name=Value".
        [Switch]$IncludePadding,

        # When writing the name only, exclude the equals symbol which normally separates the name and value.
        [Switch]$NameOnly,

        # If the INI file already exists the files current encoding will be used. If not, an encoding may be specified using this parameter. By default, files are saved using UTF8 encoding with no BOM.
        [Encoding]$Encoding = [System.Text.UTF8Encoding]::new($false),

        # The default end of line character used when creating new files.
        [ValidateSet("`r`n", "`n")]
        [String]$EndOfLine = [Environment]::NewLine
    )

    process {
        $Path = $pscmdlet.GetUnresolvedProviderPathFromPSPath($Path)

        $eolParam = @{
            EndOfLine = $EndOfLine
        }

        if ($ExpandEnvironmentVariables) {
            $null = $psboundparameters.Remove('ExpandEnvironmentVariables')
            $NewValue = [Environment]::ExpandEnvironmentVariables($NewValue)
        }
        if ($NameOnly) {
            $newItem = $Name
        } else {
            $newItem = '{0}{2}={2}{1}' -f $Name, $NewValue, @('', ' ')[$IncludePadding.ToBool()]
        }

        if (Test-Path $Path) {
            $eolParam['EndOfLine'] = GetEol -Path $Path

            $streamReader = [StreamReader][File]::OpenRead($Path)
            $content = $streamReader.ReadToEnd()
            $encoding = $streamReader.CurrentEncoding
            $streamReader.Close()

            $null = $psboundparameters.Remove('NewValue')
            $null = $psboundparameters.Remove('ExpandEnvironmentVariables')
            $null = $psboundparameters.Remove('IncludePadding')
            $null = $psboundparameters.Remove('NameOnly')
            $null = $psboundparameters.Remove('Encoding')
            $null = $psboundparameters.Remove('EndOfLine')

            [PSObject[]]$existingItems = Get-IniFileItem @psboundparameters
            if ($existingItems) {
                [Array]::Reverse($existingItems)

                foreach ($existingItem in $existingItems) {
                    if ($existingItem.Value -ne $NewValue) {
                        if (-not $existingItem.Extent.IsAssignedValue -and $NewValue) {
                            $NewValue = '={1}{0}' -f $NewValue, @('', ' ')[$IncludePadding.ToBool()]
                        } elseif ($NameOnly -and $existingItem.Extent.IsAssignedValue -and -not $NewValue) {
                            $existingItem.Extent.ValueStart--
                            $existingItem.Extent.ValueLength++
                        }

                        $content = $content.Remove(
                            $existingItem.Extent.ValueStart,
                            $existingItem.Extent.ValueLength
                        ).Insert(
                            $existingItem.Extent.ValueStart,
                            $NewValue
                        )
                    }
                }
            } else {
                if (-not $Section) {
                    $Section = '<Undefined>'
                }
                $existingSection = Get-IniFileSection -Name $Section -Path $Path

                if ($existingSection) {
                    $position = $existingSection.Extent.End
                } else {
                    if ($Section -eq '<Undefined>') {
                        $position = 0
                    } else {
                        $content = UpdateString -String $content -Value ('[{0}]' -f $Section) @eolParam
                        $position = $content.Length
                    }
                }
                $content = UpdateString -String $content -Value $newItem -Position $position @eolParam
            }
        } else {
            $content = ''

            if ($Section) {
                $content = UpdateString -String $content -Value ('[{0}]' -f $Section) @eolParam
            }
            $content = UpdateString -String $content -Value $newItem @eolParam
        }

        if ($pscmdlet.ShouldProcess(('Updating file {0}, {1} with value {2}' -f $Path, $Name, $NewValue))) {
            [File]::WriteAllText(
                $Path,
                $content,
                $encoding
            )
        }
    }
}
