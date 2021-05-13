using namespace System.IO

function Get-IniFileSection {
    <#
    .SYNOPSIS
        Get a section from an Ini file.

    .DESCRIPTION
        Reads an Ini file, returning matching sections.

        The ini file sections returned by this function includes an Extent property which describes the location of a section within the file.

    .EXAMPLE
        Get-IniFileItem -Path somefile.ini

        Get all sections in somefile.ini.

    .EXAMPLE
        Get-IniFileSection -Name somesection -Path somefile.ini

        Get the section named "somesection" from somefile.ini.
    #>

    [CmdletBinding()]
    [OutputType('IniFileSection')]
    param (
        # The name of the field to retrieve. The Name parameter supports wildcards. By default, all fields are returned.
        [string]$Name = '*',

        # The path to an ini file.
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('FullName')]
        [string]$Path
    )

    process {
        try {
            $Path = $pscmdlet.GetUnresolvedProviderPathFromPSPath($Path)
            $eolLength = (GetEol -Path $Path).Length

            $streamReader = [StreamReader][File]::OpenRead($Path)

            $Section = [PSCustomObject]@{
                Name   = '<Undefined>'
                Items  = @()
                Extent = [PSCustomObject]@{
                    Start = 0
                    End   = 0
                }
            }

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
                        if ($Section.Name -ne '<Undefined>' -or $Section.Items.Count -gt 0) {
                            $Section.Extent.End = $lastPosition
                            $Section | Where-Object Name -like $Name
                        }

                        $Section = [PSCustomObject]@{
                            Name       = $matches[1]
                            Items      = @()
                            Extent     = [PSCustomObject]@{
                                Start = $position
                                End   = 0
                            }
                            PSTypeName = 'IniFileSection'
                        }
                        break
                    }
                    '^([^=]+?) *= *(.*)$' {
                        $Section.Items += [PSCustomObject]@{
                            Name  = $matches[1]
                            Value = $matches[2]
                        }
                        break
                    }
                }

                $lastPosition = $position
                $position += $eolLength
            }

            $streamReader.Close()

            $Section.Extent.End = $lastPosition
            $Section | Where-Object Name -like $Name
        } catch {
            $pscmdlet.WriteError($_)
        } finally {
            if ($streamReader) {
                $streamReader.Close()
            }
        }
    }
}
