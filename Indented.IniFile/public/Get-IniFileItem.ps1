using namespace System.IO

function Get-IniFileItem {
    <#
    .SYNOPSIS
        Get an item from an Ini file.
    .DESCRIPTION
        Reads an Ini file, returning matching items.

        The ini file items returned by this function include an Extent property which describes the location of an item within the file.
    .EXAMPLE
        Get-IniFileItem -Path somefile.ini

        Get all items in somefile.ini.
    .EXAMPLE
        Get-IniFileItem -Section somesection -Path somefile.ini

        Get all items within the second "somesection" from somefile.ini.
    .EXAMPLE
        Get-IniFileItem -Name somename -Path somefile.ini

        Get all items named somename from any section.
    #>

    [CmdletBinding(DefaultParameterSetName = 'DefaultSearch')]
    [OutputType([System.Management.Automation.PSObject])]
    param (
        # The name of the field to retrieve. The Name parameter supports wildcards. By default, all fields are returned.
        [Parameter(Position = 1)]
        [String]$Name = '*',

        # The section a setting resides within. The Section parameter supports wildcrds. By default, all sections are returned.
        [Parameter(Position = 2)]
        [string]$Section = '*',

        # The path to an ini file.
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('FullName')]
        [String]$Path,

        # The value may be defined to describe the item. Wildcards are supported.
        [Parameter(Mandatory, ParameterSetName = 'SearchUsingValue')]
        [String]$Value,

        # The literal value may be defined to absolutely describe the item. Wildcards are not supported.
        [Parameter(Mandatory, ParameterSetName = 'SearchUsingLiteralValue')]
        [String]$LiteralValue
    )

    process {
        try {
            $Path = $pscmdlet.GetUnresolvedProviderPathFromPSPath($Path)
            $eolLength = (GetEol -Path $Path).Length

            $streamReader = [StreamReader][File]::OpenRead($Path)
            $position = 0
            while (-not $streamReader.EndOfStream) {
                switch -Regex ($streamReader.ReadLine()) {
                    '' {
                        $position += $_.Length
                    }
                    '^;' {
                        break
                    }
                    '^\[([^\]]+)\] *$' {
                        $SectionName = $matches[1]
                        $SectionStart = $position - $_.Length
                        break
                    }
                    '^([^=]+?) *= *(.*)$' {
                        [PSCustomObject]@{
                            Name       = $matches[1]
                            Value      = $matches[2]
                            Section    = $SectionName
                            Extent     = [PSCustomObject]@{
                                SectionStart = $SectionStart
                                ItemStart    = $position - $_.Length
                                ItemEnd      = $position
                                ItemLength   = $_.Length
                                ValueStart   = $position - $matches[2].Length
                                ValueLength  = $matches[2].Length
                            }
                            Path       = $Path
                            PSTypeName = 'IniFileItem'
                        } | Where-Object {
                            $_.Name -like $Name -and
                            $_.Section -like $Section -and
                            ($pscmdlet.ParameterSetName -ne 'SearchUsingValue' -or $_.Value -like $Value) -and
                            ($pscmdlet.ParameterSetName -ne 'SearchUsingLiteralValue' -or $_.Value -like $LiteralValue)
                        }
                        break
                    }
                }

                # End of line character
                $position += $eolLength
            }
        } catch {
            $pscmdlet.WriteError($_)
        } finally {
            if ($streamReader) {
                $streamReader.Close()
            }
        }
    }
}