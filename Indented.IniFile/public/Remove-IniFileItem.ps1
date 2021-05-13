using namespace System.Collections.Generic
using namespace System.Management.Automation

function Remove-IniFileItem {
    <#
    .SYNOPSIS
        Get an item from an Ini file.

    .DESCRIPTION
        Reads an Ini file, returning matching items.

    .EXAMPLE
        Remove-IniFileItem -Name somename -Section somesection -Path somefile.ini

        Remove somename from the somesection section in somefile.ini.

    .EXAMPLE
        Remove-IniFileItem -Name somename -Path somefile.ini

        Remove somename from all sections in somefile.ini.

    .EXAMPLE
        Remove-IniFileItem -Name extension -Value imap -Section PHP

        Remove extension, when the value is imap, from the section PHP.
    #>

    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'DefaultSearch')]
    [OutputType([Void])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'FromPipeline')]
        [PSTypeName('IniFileItem')]
        [PSObject]$InputObject,

        # The name of the field to retrieve.
        [Parameter(Mandatory, Position = 1, ParameterSetName = 'DefaultSearch')]
        [Parameter(Mandatory, Position = 1, ParameterSetName = 'SearchUsingValue')]
        [Parameter(Mandatory, Position = 1, ParameterSetName = 'SearchUsingLiteralValue')]
        [String]$Name,

        # The section a setting resides within. If this value is not set the value will be removed from all sections.
        [Parameter(Position = 2, ParameterSetName = 'DefaultSearch')]
        [Parameter(Position = 2, ParameterSetName = 'SearchUsingValue')]
        [Parameter(Position = 2, ParameterSetName = 'SearchUsingLiteralValue')]
        [String]$Section,

        # The path to an ini file.
        [Parameter(Mandatory, Position = 3, ParameterSetName = 'DefaultSearch')]
        [Parameter(Mandatory, Position = 3, ParameterSetName = 'SearchUsingValue')]
        [Parameter(Mandatory, Position = 3, ParameterSetName = 'SearchUsingLiteralValue')]
        [ValidateScript( { Test-Path $_ -PathType Leaf } )]
        [String]$Path,

        # The value may be defined to describe the item. Wildcards are supported.
        [Parameter(Mandatory, ParameterSetName = 'SearchUsingValue')]
        [String]$Value,

        # The literal value may be defined to absolutely describe the item. Wildcards are not supported.
        [Parameter(Mandatory, ParameterSetName = 'SearchUsingLiteralValue')]
        [String]$LiteralValue
    )

    begin {
        $null = $psboundparameters.Remove('WhatIf')

        if ($pscmdlet.ParameterSetName -eq 'FromPipeline') {
            $iniFileItems = [List[PSObject]]::new()
        } else {
            Get-IniFileItem @psboundparameters | Remove-IniFileItem
        }
    }

    process {
        if ($pscmdlet.ParameterSetName -eq 'FromPipeline') {
            $iniFileItems.Add($InputObject)
        }
    }

    end {
        if ($pscmdlet.ParameterSetName -eq 'FromPipeline' -and $iniFileItems.Count -gt 0) {
            foreach ($group in $iniFileItems | Group-Object Path) {
                $iniFilePath = $pscmdlet.GetUnresolvedProviderPathFromPSPath($group.Name)

                $eolLength = (GetEol -Path $iniFilePath).Length

                $streamReader = [StreamReader][File]::OpenRead($iniFilePath)
                $encoding = $streamReader.CurrentEncoding
                $content = $streamReader.ReadToEnd()
                $streamReader.Close()

                $items = $group.Group | Sort-Object { $_.Extent.ItemStart } -Descending
                foreach ($item in $items) {
                    if ($content.Length -gt $item.Extent.ItemStart + $item.Extent.ItemLength + $eolLength) {
                        $itemLength = $item.Extent.ItemLength + $eolLength
                    } else {
                        $itemLength = $item.Extent.ItemLength
                    }
                    $content = $content.Remove($item.Extent.ItemStart, $itemLength)
                }

                if ($pscmdlet.ShouldProcess(('Updating INI file {0}' -f $iniFilePath))) {
                    [File]::WriteAllText(
                        $iniFilePath,
                        $content,
                        $encoding
                    )
                }
            }
        }
    }
}
